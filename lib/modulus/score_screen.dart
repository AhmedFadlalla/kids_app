import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_app/data/question_data.dart';
import 'package:kids_app/layouts/cubit/cubit.dart';
import 'package:kids_app/layouts/cubit/state.dart';
import 'package:kids_app/modulus/quiz_screen.dart';
import 'package:kids_app/shared/component/components.dart';

import '../layouts/kids_home_layout.dart';
import '../shared/component/constants.dart';
import '../shared/styles/colors.dart';

class ScoreScreen extends StatefulWidget {
  final int score;

  const ScoreScreen({Key? key,required this.score}) : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}
enum ScoreWidgetStatus {
  HIDDEN,
  BECOMING_VISIBLE,
  VISIBLE,
  BECOMING_INVISIBLE
}

class _ScoreScreenState extends State<ScoreScreen> with TickerProviderStateMixin {
  ConfettiController? controller;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=ConfettiController(duration: const Duration(seconds: 1));
    controller!.play();

    //clapp

  }









  static const double right=0.0;
  static const double down=pi/2;
  static const double left=pi;
  static const double top=-pi/2;

  final double blastDirection=top;



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KidsCubit,KidsState>(
        builder: (context,state){

          return Scaffold(
            backgroundColor: const Color(0xFF252c4a),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: ConfettiWidget(
                      confettiController:controller!,
                      colors: const [
                        Colors.red,
                        Colors.blue,
                        Colors.orange,
                        Colors.purple,
                        Colors.lightBlue,
                      ],
                      shouldLoop: true,
                      emissionFrequency: 0.05,
                      numberOfParticles: 20,
                      // blastDirection: blastDirection,
                      blastDirectionality: BlastDirectionality.explosive,

                    ),
                  ),
                  Center(
                    child: Text(
                        '$uId أحسنت , رائع ',
                      style: GoogleFonts.oswald(
                        textStyle: const TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            color:Colors.white,
                            fontFamily: 'Rama'

                        ),
                    )
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Text(
                      '  النتيجة : ${widget.score}/ ${questions.length*10}',
                    style: GoogleFonts.oswald(
                      textStyle: const TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color:Colors.white,
                          fontFamily: 'Rama'

                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  SizedBox(
                    width: 100,
                    child: defaultButton(
                        function: (){
                      navigateTo(context, const KidsHomeScreenLayouts(currentIndex: 1,));
                    }, text: 'اعادة الامتحان'),
                  ),


                ],
              ),
            ),


          );
        }, listener: (context,state){

    });
  }





}
