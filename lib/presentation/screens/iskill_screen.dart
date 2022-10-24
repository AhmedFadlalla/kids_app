import 'package:audioplayers/audioplayers.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kids_app/presentation/controller/Home/home_bloc.dart';
import 'package:kids_app/presentation/controller/Home/home_state.dart';
import 'package:xen_popup_card/xen_card.dart';

import '../../presentation/controller/app_cubit/cubit.dart';
import '../../core/services/service_locator.dart';
import '../../domain/entities/base_skill_data.dart';
import 'component/components.dart';
import '../../shared/component/constants.dart';
import '../controller/Home/home_event.dart';
import 'home_screen.dart';


class ISkillsScreen extends StatefulWidget {
  final String skillName;
  const ISkillsScreen({
    Key? key,
    required this.skillName
  }) : super(key: key);

  @override
  State<ISkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<ISkillsScreen> {

  List<Color>colors=[
    Color(0xFFff008B),
    Color(0xFF00e8ff),
    Color(0xffae00ff),
    Color(0xFF0068ff),

  ];
  XenCardAppBar appBar = const XenCardAppBar(
    child: Text(
      "الاعدادات",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
    ),
    // To remove shadow from appbar
    shadow: BoxShadow(color: Colors.green),
  );

  XenCardGutter gutter = const XenCardGutter(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CustomButton(text: "close"),
    ),
  );

  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (context)=>sl<HomeBloc>()..add(GetSkillDataEvent(skillName: widget.skillName)),
      child: BlocBuilder<HomeBloc,HomeState>(
    builder: (context,state){
      var skillData=state.skillData;
      return Scaffold(
        appBar: AppBar(
          title: const Text('الصفحة الرئيسيه'),
          actions: [cardWithGutterAndAppBar(context)],
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
              itemBuilder: (context, index) => buildSkillCard(
                  skillData[index],
                  colors[index],
                  context),
              separatorBuilder: (context, index) => const SizedBox(
                height: 25,
              ),
              itemCount: skillData.length,
            ),
          ),
        ),
      );
    },
    ),
    );
  }

  Widget buildSkillCard(BaseSkillData model, Color color, context) => InkWell(
      child: Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: color),
          height: 200,
          child: Stack(
            children: [
              Positioned(
                  right: 10,
                  top: 50,
                  child: Text(model.name,
                      style: GoogleFonts.mochiyPopOne(
                        textStyle: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Rama'),
                      ))),
              Positioned(
                  top: 10,
                  child: Image(
                    image: NetworkImage(model.image),
                    fit: BoxFit.cover,
                    height: 170,
                    width: 200,
                  ))
            ],
          )),
      onTap: () {
        if (model.skillAudio != "null") {
          audioPlayer.setSourceUrl(model.skillAudio).then((value) {
            audioPlayer.resume();
            navigateTo(context,  HomeScreen(
              videoUrl: model.videos,
              audioUrl: model.audio,
              masrah: model.masrah,
              conversation: model.conversation,
            ));
          });
        }else{
          // KidsCubit.get(context).videoUrl = model.videos;
          // KidsCubit.get(context).audio = model.audio;
          // KidsCubit.get(context).description = model.description;
          // KidsCubit.get(context).name = model.name;
          navigateTo(context,   HomeScreen(
            videoUrl: model.videos,
            audioUrl: model.audio,
            masrah: model.masrah,
            conversation: model.conversation,
          ));

        }
      });

  Widget cardWithGutterAndAppBar(context) => TextButton(
    onPressed: () => showDialog(
      context: context,
      builder: (builder) => XenPopupCard(
        appBar: appBar,
        gutter: gutter,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        appCubit.get(context).changeAudio();
                        mainAudioPlayer.resume();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.green),
                            color: appCubit.get(context).isPlay
                                ? Colors.blue
                                : Colors.white),
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
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        appCubit.get(context).changeAudio();
                        mainAudioPlayer.pause();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.green),
                            color: appCubit.get(context).isPlay
                                ? Colors.white
                                : Colors.blue),
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
}
