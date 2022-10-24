import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/services/service_locator.dart';
import '../../../controller/Home/home_bloc.dart';
import '../../../controller/Home/home_state.dart';
class MasrahyaScreen extends StatefulWidget {
  final String video;

  const MasrahyaScreen({
    Key? key,
    required this.video
  }) : super(key: key);

  @override
  State<MasrahyaScreen> createState() => _MasrahyaScreenState();
}

class _MasrahyaScreenState extends State<MasrahyaScreen> {
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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.pause();
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
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        widget.video)
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
    // player.setSourceUrl(widget.audioUrl);
  }


  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context)=>sl<HomeBloc>(),
      child: BlocBuilder<HomeBloc,HomeState>(
        builder: (context,state){
          var data=state.skillDetailsData;
          return Scaffold(
            appBar: AppBar(),
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


                ],
              ),
            ),

          );
        },
      ),
    );
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
  void changeToSecond(int second){
    Duration newDuration=Duration(seconds: second);
    player.seek(newDuration);
  }
  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }
}
