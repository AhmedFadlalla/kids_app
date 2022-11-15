import 'dart:async';
import '../../core/utils/enum.dart';
import '../../presentation/controller/app_cubit/cubit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_app/domain/entities/base_main_skill.dart';
import 'package:kids_app/presentation/controller/Home/home_bloc.dart';
import 'package:kids_app/presentation/controller/Home/home_state.dart';
import 'package:kids_app/shared/component/constants.dart';
import 'package:xen_popup_card/xen_card.dart';
import 'package:kids_app/presentation/screens/component/components.dart';
import '../../core/services/service_locator.dart';
import '../controller/Home/home_event.dart';
import '../controller/app_cubit/states.dart';
import 'iskill_screen.dart';


class IHomeScreen extends StatefulWidget {
  const IHomeScreen({Key? key}) : super(key: key);

  @override
  State<IHomeScreen> createState() => _KidsHomeScreenState();
}

class _KidsHomeScreenState extends State<IHomeScreen> {

  AudioPlayer audioPlayer=AudioPlayer();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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

  List<Color>colors=[
    Color(0xFFff008B),
    Color(0xFF00e8ff),
    Color(0xffae00ff),
    Color(0xFF0068ff),

  ];
  @override
  Widget build(BuildContext context) {


    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (context)=>sl<HomeBloc>()..add(GetMainSkillDataEvent())..add(GetAudiosDataEvent()),
      child: BlocBuilder<HomeBloc,HomeState>(
          builder: (context,state){
       switch (state.mainSkillDataState){

         case RequestState.loading:
           return  Scaffold(
             body: Container(
               height: height,
               decoration: const BoxDecoration(

                   gradient: LinearGradient(
                       colors: [
                         Color(0xFF0f17ad),
                         Color(0xFF6985e8),
                       ]
                   )

               ),
               child: const Center(child: CircularProgressIndicator(),)
             ),
           );
         case RequestState.loaded:
           return Scaffold(
             appBar: AppBar(
               title: const Text(
                   'الصفحة الرئيسيه'
               ),
               actions: [
                 TextButton(onPressed: (){
                   showDialog(context: context, builder: (builder){
                     var audios=state.audiosData;
                     return BlocProvider(
                       create: (context)=>appCubit(),
                       child: BlocConsumer<appCubit,AppStates>
                         (builder: (context,state){
                         return AlertDialog(
                           title: Text("الاعدادات"),
                           content: SingleChildScrollView(
                             child: ListBody(
                               children: [
                                 Row(
                                   children: [
                                     Expanded(
                                       child: InkWell(
                                         onTap: (){
                                           appCubit.get(context).changeAudio();
                                           audioPlayer.setSourceUrl(audios[2].audio).then((value) {
                                             audioPlayer.resume();
                                           });
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
                                           audioPlayer.pause();

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
                         );
                       }, listener: (context,state){}),
                     );
                   });
                 }, child:const  Icon(
                   Icons.settings,
                   color: Colors.white,
                 ))
               ],
             ),
             body: Container(
               height: height,
               decoration: const BoxDecoration(

                   gradient: LinearGradient(
                       colors: [
                         Color(0xFF0f17ad),
                         Color(0xFF6985e8),
                       ]
                   )

               ),
               child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: ListView.separated(
                   shrinkWrap: true,
                   physics: const BouncingScrollPhysics(),
                   itemBuilder: (context,index)=>buildSkillCard(
                       state.mainSkillData[index],
                       colors[index]),
                   separatorBuilder:(context,index)=>const SizedBox(
                     height: 25,
                   ) ,
                   itemCount: state.mainSkillData.length,
                 ),
               ),
             ),
           );
         case RequestState.error:
           return Center(child: Text(state.mainSkillDataMessage),);
       }
      }),
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
  Widget buildSkillCard(BaseMainSkillData model,Color color)=>InkWell(
    child: Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      margin: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
          color: color,
        shape: BoxShape.circle
      ),
      height: 200,
      child: Center(
        child: Text(
            model.name,
            style: GoogleFonts.mochiyPopOne(
              textStyle: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Rama'

              ),
            )
        ),
      ),
    ),
    onTap:(){
      if(model.audio!="null"){
        audioPlayer.setSourceUrl(model.audio).then((value) {
          mainAudioPlayer.stop();
          audioPlayer.resume();

          navigateTo(context,  ISkillsScreen(skillName: model.name,));
        });
      }else{

        navigateTo(context,  ISkillsScreen(skillName: model.name));
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
