import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_app/presentation/screens/component/components.dart';
import 'package:lottie/lottie.dart';

import '../../../shared/component/constants.dart';
class ContainerDesignScreen extends StatelessWidget {
  final Color color;
  final String text;
  final  Widget widget;
  final String lottieFile;
  const ContainerDesignScreen({
    Key? key,
    required this.color,
    required this.text,
    required this.widget,
    required this.lottieFile

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: double.infinity,
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(25)
        ),
        height: 200,
        child: Row(
          children: [
            Lottie.asset(
                lottieFile,
              width:200,
              animate: true
            ),
            const Spacer(),
            Text(
                text,
                style: GoogleFonts.mochiyPopOne(
                  textStyle: const TextStyle(
                      fontSize:35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Rama'

                  ),
                )
            ),
          ],
        ),
      ),
      onTap:(){
        mainAudioPlayer.pause();
        navigateTo(context, widget);
      },

    );
  }
}
