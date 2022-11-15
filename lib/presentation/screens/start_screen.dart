import 'package:flutter/material.dart';
import 'package:kids_app/presentation/screens/component/components.dart';
import 'package:kids_app/presentation/screens/ihome_screen.dart';
import 'package:lottie/lottie.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xFF0f17ad),
              Color(0xFF6985e8),
            ])),
        child: SafeArea(
          child:Column(
            children: [
              Lottie.asset("assets/lottie/kids.json"),
              SizedBox(
                height: height*0.35,
              ),
              Container(
                width: width*0.75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                ),
                child: MaterialButton(
                  height: 38,
                  onPressed: (){
                    navigateTo(context,const IHomeScreen());
                  },
                  child: const Text(
                      "ابدأ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28
                    ),
                  ),
                  color: const Color(0xffff009b),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
