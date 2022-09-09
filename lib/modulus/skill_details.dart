import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:kids_app/modulus/quiz_screen.dart';

import 'package:video_player/video_player.dart';

import '../layouts/cubit/cubit.dart';
import '../layouts/cubit/state.dart';
import '../shared/component/components.dart';

class SkillDetailsScreen extends StatefulWidget {
  final String videoUrl;
  final String audio;
  final String description;
  final String name;



   SkillDetailsScreen(this.videoUrl,this.audio,this.name,this.description);

  @override
  _VideoAppState createState() => _VideoAppState(videoUrl,audio,name,description);
}

class _VideoAppState extends State<SkillDetailsScreen> {
  final String videoUrl;
  final String audioUrl;
  final String description;
  final String name;
  _VideoAppState(this.videoUrl,this.audioUrl,this.name,this.description);
  VideoPlayerController? _controller;
  Duration? _duration, _position,duration=const Duration(),position=const Duration();
  var _progress = 0.0;
  var _onUpdateControllerTime;
  bool _disposed = false;
  bool _isPlaying = false;
  AudioPlayer player=AudioPlayer();
  bool audioPlaying=false;
  bool audioPaused=false;
  bool audioLoop=false;




  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        videoUrl)
      ..initialize().then((_) {
        _controller?.addListener(onControllerUpdate);
        setState(() {});
      });
    player.onDurationChanged.listen((event) {
      setState(() {
        duration=event;
      });
    });
    player.onPositionChanged.listen((event) {
      setState(() {
        position=event;
      });
    });
    player.setSourceUrl(audioUrl);
  }

  void onControllerUpdate() async {

    if (_disposed) {
      return;
    }
    _onUpdateControllerTime = 0;
    final now = DateTime
        .now()
        .microsecondsSinceEpoch;
    if (_onUpdateControllerTime > now) {
      return;
    }
    _onUpdateControllerTime = now + 500;


    final controller=_controller;
    if(controller ==null){
      debugPrint('Controller is null');
      return;
    }
    if(!controller.value.isInitialized ){
      debugPrint('Controller can not be initialized');
      return;
    }
    _duration ??= _controller!.value.duration;
    var duration = _duration;
    if (duration == null) return;
    var position = await _controller!.position;

    _position = position;

    final playing = _controller!.value.isPlaying;
    if (playing) {
      if (_disposed) return;
      setState(() {
        _progress = _position!.inMicroseconds.ceilToDouble() /
            _duration!.inMicroseconds.ceilToDouble();
      });
    }
    _isPlaying = playing;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;

    return BlocConsumer<KidsCubit, KidsState>(
        builder: (context, state) {
          return Scaffold(

            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF0f17ad),
                        Color(0xFF6985e8),
                      ]
                  )
              ),
              child: Column(
                children: [
                  SizedBox(height: height * 0.03,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children:  [
                      InkWell(
                          child: const Icon(
                              Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        onTap: (){
                            Navigator.pop(context);
                        },
                      ),
                       const Spacer(),
                        InkWell(
                          child: const Icon(
                            Icons.question_mark,
                            color: Colors.white,
                          ),
                          onTap: (){
                            navigateTo(context,const QuizScreen());
                          },
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      _controller!.value.isInitialized
                          ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),

                        ),

                        child: AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: VideoPlayer(_controller!),
                        ),
                      )
                          : Container(),
                      _controlView(context)


                    ],
                  ),
                  SizedBox(height: height * 0.01,),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(60),
                              topLeft: Radius.circular(60)
                          ),
                          color: Colors.white
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:   [

                               Text(
                                 name ,
                                style:const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(position.toString().split(".")[0],style:const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey
                                  ),),
                                  const Spacer(),
                                  Text(duration.toString().split(".")[0],style:const TextStyle(
                                      fontSize:15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),)
                                ],
                              ),
                              Slider(
                                  value: position!.inSeconds.toDouble(),
                                  min: 0.0,
                                  max: duration!.inSeconds.toDouble(),
                                  onChanged: (double value){
                                    setState(() {
                                      changeToSecond(value.toInt());
                                      value=value;
                                    });
                                  }),
                              Center(
                                child: GestureDetector(
                                  child: CircleAvatar(
                                    radius: 25,
                                    child: Icon(
                                      audioPlaying==false ? Icons.play_arrow : Icons
                                          .pause,
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {

                                    if(audioPlaying==false)
                                    {
                                      player.resume();
                                      setState(() {
                                        audioPlaying=true;
                                      });
                                    }
                                    else if(audioPlaying==true){
                                      player.pause();
                                      setState(() {
                                        audioPlaying=false;
                                      });
                                    }



                                  },
                                ),
                              ),
                              const SizedBox(height: 15,),
                              Center(
                                child: Text(description,style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.black
                                ),),
                              )

                            ],
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),

          );
        },
        listener: (context, state) {});
  }

  void changeToSecond(int second){
    Duration newDuration=Duration(seconds: second);
    player.seek(newDuration);
  }
  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  Widget _controlView(context) {
    final noMute = (_controller?.value.volume ?? 0) > 0;
    final duration = _duration?.inSeconds ?? 0;
    final head = _position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo(remained % 60);
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return Column(
      children: [
        defaultSlider(),
        Container(
          color: Colors.black.withOpacity(0.4),
          child: Row(
            children: [

              SizedBox(width: width * 0.05,),
              GestureDetector(
                child: noMute ? const Icon(
                  Icons.volume_up,
                  color: Colors.white,
                ) : const Icon(
                  Icons.volume_off,
                  color: Colors.white,
                ),
                onTap: () {
                  if (noMute) {
                    _controller?.setVolume(0);
                  }
                  else {
                    _controller?.setVolume(1.0);
                  }
                  setState(() {

                  });
                },
              ),
              SizedBox(width: width * 0.35,),
              GestureDetector(
                child: CircleAvatar(
                  radius: 25,
                  child: Icon(
                    _controller!.value.isPlaying ? Icons.pause : Icons
                        .play_arrow,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    if (_controller!.value.isPlaying) {

                      _controller?.pause();
                    }
                    else {

                      _controller?.play();
                    }
                  });
                },
              ),
              const Spacer(),
              Text(
                '$mins:$secs',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white
                ),
              )

            ],
          ),
        ),
      ],
    );
  }
  Widget defaultSlider()=>SliderTheme(
      data: const
      SliderThemeData(
        thumbColor: Colors.green,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20),
        trackHeight: 2.0,
        trackShape: RoundedRectSliderTrackShape(),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),



      ),
      child: Slider(
        value: max(0, min(_progress *100, 100)),
        min: 0,
        max: 100,
        divisions: 100,
        label: _position?.toString().split(".")[0],
        onChanged: (value){
          debugPrint('value ${value* 0.01 }');
          setState(() {
            _progress=value * 0.01;
          });
        },
        onChangeStart: (value){
          _controller?.pause();
        },
        onChangeEnd: (value){
          final duration=_controller?.value.duration;
          debugPrint('duration $duration');
          if(duration!=null){
            var newValue=max(0, min(value, 99))*0.01;
            var millis=(duration.inMicroseconds*newValue).toInt();
            _controller?.seekTo(Duration(milliseconds: millis));
            _controller?.play();
          }
        },

      ));

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
    _controller?.dispose();
  }
}