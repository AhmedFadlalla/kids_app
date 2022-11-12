import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kids_app/shared/network/endpoints.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AudioScreen extends StatefulWidget {
  final String url;

  const AudioScreen({
    Key? key,
    required this.url
  }) : super(key: key);

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {

  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
     controller=
        YoutubePlayerController(
            initialVideoId:YoutubePlayer.convertUrlToId(widget.url)!,

          flags: const YoutubePlayerFlags(
            mute: false,
            loop: false,
            autoPlay: true,
          )
        );

  }



  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: controller),
      builder:(context,player)=> Scaffold(
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
          child: ListView(
            children: [
              player
            ],
          ),
        ),

      ),
    );
  }





  @override
  void dispose() {
    controller.pause();
    super.dispose();

  }
}
