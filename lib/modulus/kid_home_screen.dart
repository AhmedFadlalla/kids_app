import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_app/layouts/kids_home_layout.dart';
import 'package:kids_app/models/data_model.dart';
import 'package:kids_app/models/main_skill_data_model.dart';
import 'package:kids_app/modulus/skill_category.dart';
import 'package:kids_app/modulus/skill_details.dart';
import 'package:kids_app/modulus/skills_screen.dart';
import 'package:kids_app/shared/component/constants.dart';
import 'package:kids_app/shared/cubit/cubit.dart';
import 'package:kids_app/shared/network/local/cach_helper.dart';
import 'package:xen_popup_card/xen_card.dart';

import 'package:kids_app/shared/component/components.dart';

import '../layouts/cubit/cubit.dart';
import '../layouts/cubit/state.dart';
import '../shared/network/endpoints.dart';
import 'audio/audio_asset.dart';

class KidsHomeScreen extends StatefulWidget {
  const KidsHomeScreen({Key? key}) : super(key: key);

  @override
  State<KidsHomeScreen> createState() => _KidsHomeScreenState();
}

class _KidsHomeScreenState extends State<KidsHomeScreen> {
  final player = AudioAssetPlayer('audio/sound1.mp3');

  AudioPlayer audioPlayer=AudioPlayer();

  // late final StreamSubscription progressSubscription;
  // late final StreamSubscription streamSubscription;

  // double progress = 0.0;
  // PlayerState state = PlayerState.stopped;
  //
  // late final Future initFuture;
  play()async{
    // await=audioPlayer.pl;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  XenCardAppBar appBar = const XenCardAppBar(
    child: Text(
      "الاعدادات",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
    ),
    // To remove shadow from appbar
    shadow: BoxShadow(color: Colors.green),
  );

  // GUTTER
  //
  // [XenCardGutter]
  XenCardGutter gutter = const XenCardGutter(
    
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CustomButton(text: "close"),
    ),
  );


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<KidsCubit, KidsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit=KidsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'الصفحة الرئيسيه'
            ),
            actions: [
              cardWithGutterAndAppBar()
            ],
          ),

          backgroundColor: const Color(0xFF252c4a),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ConditionalBuilder(
                condition: cubit.mainSkillsData.isNotEmpty,
                builder: (context)=>ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>buildSkillCard(
                      cubit.mainSkillsData[index],
                      cubit.colors[index]),
                  separatorBuilder:(context,index)=>const SizedBox(
                    height: 25,
                  ) ,
                  itemCount: cubit.mainSkillsData.length,
                ),
                fallback:(context)=> const Center(child: CircularProgressIndicator())),
          ),
        );
      },
    );
  }

  Widget cardWithGutterAndAppBar() => TextButton(
    onPressed: () => showDialog(
      context: context,
      builder: (builder) => XenPopupCard(


        appBar: appBar,
        gutter: gutter,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(

            children: [
              const SizedBox(height: 25,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        appCubit.get(context).changeAudio();
                        mainAudioPlayer.resume();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.green),
                          color: appCubit.get(context).isPlay?Colors.blue:Colors.white
                        ),
                        child: Row(
                          children: const [
                            Icon(
                                Icons.volume_up,
                              color: Colors.green,
                              size: 35,
                            ),
                            Text(
                                'تشغيل',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                 const  SizedBox(width: 12,),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        appCubit.get(context).changeAudio();
                        mainAudioPlayer.pause();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.green),
                          color: appCubit.get(context).isPlay?Colors.white:Colors.blue
                        ),


                        child: Row(
                          children: const [
                            Icon(
                              Icons.volume_off,
                              color: Colors.red,
                              size: 35,
                            ),
                            Text(
                              'ايقاف',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
    child: const Icon(
        Icons.settings,
      color: Colors.white,
    ),
  );
  Widget cardWithBodyOnly() => TextButton(
    onPressed: () => showDialog(
      context: context,
      builder: (builder) => XenPopupCard(
        body: ListView(
          children: const [
            Text("body"),
          ],
        ),
      ),
    ),
    child: const Text("open card with body only"),
  );
  Widget cardWithAppBarOnly() => TextButton(
    onPressed: () => showDialog(
      context: context,
      builder: (builder) => XenPopupCard(
        appBar: appBar,
        body: ListView(
          children: const [
            Text("body"),
          ],
        ),
      ),
    ),
    child: const Text("open card with appbar only"),
  );
  Widget cardWithGutterOnly() => TextButton(
    onPressed: () => showDialog(
      context: context,
      builder: (builder) => XenPopupCard(
        gutter: gutter,
        body: ListView(
          children: const [
            Text("body"),
          ],
        ),
      ),
    ),
    child: const Text("open card with  gutter only"),
  );
  Widget buildSkillCard(MainSkillDataModel model,Color color)=>InkWell(
    child: Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color
      ),
      height: 200,
      child: Center(
        child: Text(
            model.name,
            style: GoogleFonts.mochiyPopOne(
              textStyle: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Rama'

              ),
            )
        ),
      ),
    ),
    onTap:(){
      if(model.audio!="null"){
        audioPlayer.setSourceUrl(model.audio).then((value) {
          audioPlayer.resume();
          KidsCubit.get(context).audio=model.audio;
          KidsCubit.get(context).name=model.name;
          KidsCubit.get(context).getSkillData(doc: model.name);
          navigateTo(context,const  SkillsScreen());
        });
      }else{
        KidsCubit.get(context).audio=model.audio;
        KidsCubit.get(context).name=model.name;
        KidsCubit.get(context).getSkillData(doc: model.name);
        navigateTo(context,const  SkillsScreen());
      }





     },

  );
  // Widget buildPlayButton() {
  //   if (state == PlayerState.playing) {
  //     return const IconButton(
  //         onPressed: null,
  //         icon: Icon(
  //           Icons.play_arrow,
  //           color: Colors.grey,
  //           size: 25.0,
  //         ));
  //   }
  //   return IconButton(
  //       onPressed: () {
  //         player.play();
  //       },
  //       icon: const Icon(
  //         Icons.play_arrow,
  //         color: Colors.grey,
  //         size: 25.0,
  //       ));
  // }
  // Widget buildPauseButton() {
  //   if (state == PlayerState.paused) {
  //     return const IconButton(
  //         onPressed: null,
  //         icon: Icon(
  //           Icons.pause,
  //           color: Colors.orange,
  //           size: 25.0,
  //         ));
  //   }
  //   return IconButton(
  //       onPressed: () {
  //         player.pause();
  //       },
  //       icon: const Icon(
  //         Icons.pause,
  //         color: Colors.orange,
  //         size: 25.0,
  //       ));
  // }
  // Widget buildStopButton() {
  //   if (state == PlayerState.stopped) {
  //     return const IconButton(
  //         onPressed: null,
  //         icon: Icon(
  //           Icons.stop,
  //           color: Colors.red,
  //           size: 25.0,
  //         ));
  //   }
  //   return IconButton(
  //       onPressed: () {
  //         player.reset();
  //       },
  //       icon: const Icon(
  //         Icons.stop,
  //         color: Colors.red,
  //         size: 25.0,
  //       ));
  // }
}
