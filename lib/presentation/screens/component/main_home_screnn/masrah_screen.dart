import 'package:audioplayers/audioplayers.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/services/service_locator.dart';
import '../../../controller/Home/home_bloc.dart';
import '../../../controller/Home/home_state.dart';
class MasrahyaScreen extends StatefulWidget {
   final VideoPlayerController videoPlayerController;

  const MasrahyaScreen({
    Key? key,
    required this.videoPlayerController
  }) : super(key: key);


  @override
  State<MasrahyaScreen> createState() => _MasrahyaScreenState();
}

class _MasrahyaScreenState extends State<MasrahyaScreen> {

  ChewieController? chewieController;


  @override
  void initState() {

    super.initState();
    chewieController= ChewieController(
        videoPlayerController: widget.videoPlayerController,
        autoPlay: true,
        looping: false,
        autoInitialize: true,
        errorBuilder: (context,errorMessage)=>Center(child: Text(errorMessage),)
      // additionalOptions: (context){
      //     return <OptionItem>[
      //       OptionItem(
      //           onTap: ()=>debugPrint('1'),
      //           iconData: Icons.add,
      //           title: 'option 1'),
      //       OptionItem(
      //           onTap: ()=>debugPrint('2'),
      //           iconData: Icons.cabin,
      //           title: 'option 2'),
      //       OptionItem(
      //           onTap: ()=>debugPrint('3'),
      //           iconData: Icons.mail,
      //           title: 'option 3')
      //     ];
      // }
    );

  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;

    print(chewieController);
    return  BlocProvider(
        create: (context)=>sl<HomeBloc>(),
      child: BlocBuilder<HomeBloc,HomeState>(
        builder: (context,state)=>Scaffold(
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
              child:chewieController!=null? Chewie(
                controller: chewieController!,
              ):const Center(child: CircularProgressIndicator()),
            )

        ),
      ),
    )
    ;
  }
   @override
   void dispose() {
     widget.videoPlayerController.pause();
     chewieController!.dispose();
     super.dispose();

   }

}
