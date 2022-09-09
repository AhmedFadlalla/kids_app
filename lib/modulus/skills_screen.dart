import 'package:audioplayers/audioplayers.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_app/models/data_model.dart';
import 'package:xen_popup_card/xen_card.dart';
import 'package:kids_app/shared/cubit/cubit.dart';
import '../layouts/cubit/cubit.dart';
import '../layouts/cubit/state.dart';
import '../layouts/kids_home_layout.dart';
import '../shared/component/components.dart';
import '../shared/component/constants.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({Key? key}) : super(key: key);

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
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
    var cubit = KidsCubit.get(context);
    return BlocConsumer<KidsCubit, KidsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = KidsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('الصفحة الرئيسيه'),
            actions: [cardWithGutterAndAppBar(context)],
          ),
          backgroundColor: const Color(0xFF252c4a),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ConditionalBuilder(
                condition: cubit.skillDataModel.isNotEmpty,
                builder: (context) => ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildSkillCard(
                          cubit.skillDataModel[index],
                          cubit.colors[index],
                          context),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 25,
                      ),
                      itemCount: cubit.skillDataModel.length,
                    ),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator())),
          ),
        );
      },
    );
  }

  Widget buildSkillCard(SkillDataModel model, Color color, context) => InkWell(
      child: Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: color),
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
            KidsCubit.get(context).videoUrl = model.videos;
            KidsCubit.get(context).audio = model.audio;
            KidsCubit.get(context).description = model.description;
            KidsCubit.get(context).name = model.name;
            navigateTo(context, const KidsHomeScreenLayouts());
          });
        }else{
          KidsCubit.get(context).videoUrl = model.videos;
          KidsCubit.get(context).audio = model.audio;
          KidsCubit.get(context).description = model.description;
          KidsCubit.get(context).name = model.name;
          navigateTo(context, const KidsHomeScreenLayouts());

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
