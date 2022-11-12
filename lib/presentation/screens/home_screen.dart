import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_app/presentation/controller/Home/home_bloc.dart';
import 'package:kids_app/presentation/controller/Home/home_state.dart';
import 'package:kids_app/presentation/screens/component/main_home_screnn/audio_screen.dart';
import 'package:video_player/video_player.dart';

import '../../core/services/service_locator.dart';
import '../controller/Home/home_event.dart';
import 'component/container_design.dart';
import 'component/main_home_screnn/conversation_screen.dart';
import 'component/main_home_screnn/masrah_screen.dart';
import 'component/main_home_screnn/show_screen.dart';
import 'component/main_home_screnn/video_screen.dart';

class HomeScreen extends StatelessWidget {
  final String videoUrl;
  final String audioUrl;
  final String conversation;
  final String masrah;

  HomeScreen({
    Key? key,
    required this.videoUrl,
    required this.audioUrl,
    required this.conversation,
    required this.masrah,
  }) : super(key: key);

  List<Color> colors = [
    Color(0xFFff008B),
    Color(0xFF00e8ff),
    Color(0xffae00ff),
    Color(0xFF0068ff),
  ];

  List<String> texts = [
    'اغنية',
    'فيديو',
    'مسرحية',
    'حوار',
  ];

  List<String> lottie = [
    'assets/lottie/music1.json',
    'assets/lottie/video.json',
    'assets/lottie/masrah.json',
    'assets/lottie/conversation.json',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>(),
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xFF0f17ad),
              Color(0xFF6985e8),
            ])),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => ContainerDesignScreen(
                    lottieFile: lottie[index],
                    color: colors[index],
                    text: texts[index],
                    widget: [
                      AudioScreen(url: audioUrl),
                      AudioScreen(url: videoUrl),
                      MasrahyaScreen(
                        videoPlayerController: VideoPlayerController
                            .network(
                            masrah
                        ),
                      ),
                      MasrahyaScreen(
                        videoPlayerController: VideoPlayerController
                            .network(
                            conversation
                        ),
                      ),
                    ][index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 25,
                ),
                itemCount: texts.length,
              ),
            ),
          ),
        );
      }),
    );
  }
}
