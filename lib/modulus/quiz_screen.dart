import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:kids_app/layouts/cubit/cubit.dart';
import 'package:kids_app/layouts/cubit/state.dart';
import 'package:kids_app/modulus/score_screen.dart';
import 'package:kids_app/shared/component/components.dart';

import '../question/question_data.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

   PageController? _controller=PageController(initialPage: 0);
   AudioPlayer audioPlayer=AudioPlayer(),mainAudioPlayer=AudioPlayer();
   bool isPressed=false;
   Color isTrue=Colors.green;
   Color isWrong=Colors.red;
   Color btnColor=Colors.blue;
   int score=0;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KidsCubit, KidsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller!,
                onPageChanged: (page){
                setState(() {
                  isPressed=false;
                });
                },
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "السؤال ${index + 1} /${questions.length}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 28.0),
                          ),
                        ),
                        myDivider(),
                        Image(image: AssetImage(questions[index].image!)),
                        Text(questions[index].question!,
                            style: GoogleFonts.mochiyPopOne(
                              textStyle: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Rama'),
                            )),
                        for(int i=0;i<questions[index].answer!.length;i++)

                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 12.0),

                              child: MaterialButton(
                                shape: const StadiumBorder(),
                                color: isPressed?
                                questions[index].answer!.entries.toList()[i].value?isTrue:isWrong:btnColor
                                ,
                                padding: const EdgeInsets.symmetric(vertical: 18),
                                onPressed: isPressed?(){}:() {
                                  setState(() {
                                    isPressed=true;
                                  });
                                  if(questions[index].answer!.entries.toList()[i].value){
                                    score+=10;
                                    if (kDebugMode) {
                                      print(score);
                                    }
                                  }
                                },
                                child: Text(
                                    questions[index].answer!.keys.toList()[i]),
                              ),
                            ),
                        const SizedBox(height: 30.0,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [
                            OutlinedButton(
                                onPressed:isPressed?index+1==questions.length?()async{
                                  await audioPlayer
                                      .setSourceUrl(KidsCubit.get(context)
                                      .audioData3!.audio).then((value) {
                                    navigateTo(context,  ScoreScreen(score: score,));
                                    for(int i=0;i<200;i++){
                                      audioPlayer.resume();
                                    }

                                  });

                                }: (){

                                  _controller!.nextPage(
                                      duration: const Duration(milliseconds: 750),
                                      curve: Curves.easeInExpo);

                                }:null,
                                child:  const Text(
                                   'السؤال التالي' ,
                              style: TextStyle(
                                color: Colors.white
                              ),
                                ),
                              style: OutlinedButton.styleFrom(
                                shape:  const StadiumBorder(),
                                side: const BorderSide(color: Colors.orange,width: 1.0)
                              ),

                            ),
                          ],
                        )


                      ],
                    ),
                  );
                }),
          );
        },
        listener: (context, state) {});
  }
}
