import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kids_app/shared/bloc_observer.dart';
import 'package:kids_app/shared/component/constants.dart';
import 'package:kids_app/shared/cubit/cubit.dart';
import 'package:kids_app/shared/network/endpoints.dart';
import 'package:kids_app/shared/network/local/cach_helper.dart';

import 'layouts/cubit/cubit.dart';
import 'layouts/kids_home_layout.dart';
import 'modulus/first_screen.dart';
import 'modulus/kid_home_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  await CachHelper.init();
  // if(audioPlay==null){
  //   CachHelper.saveData(key: audio, value: true);
  // }

  uId = CachHelper.getData(key: 'id');
  audioPlay=CachHelper.getData(key: audio);
  if (kDebugMode) {
    print(uId);
  }
  // mainAudioPlayer.setSourceUrl()
  if (kDebugMode) {
    print(audioPlay);
  }
  mainAudioPlayer.setSourceUrl('https://firebasestorage.googleapis.com/v0/b/kids-project-962cf.appspot.com/o/audio%2FFunny%20Kids%20_%20Children_s%20Music%20(Instrumental%20Music%20For%20Kids)(MP3_320K).mp3?alt=media&token=ee8f21c8-5f73-4279-90d9-14262f8f0ebf').
  then((value) {

    if(audioPlay==true){
      if (kDebugMode) {
        print("audio play");
      }
      mainAudioPlayer.resume();
      mainAudioPlayer.onPlayerComplete.listen((event) {
        mainAudioPlayer.resume();
      });
    }
    else{
      mainAudioPlayer.pause();
    }


  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create:(context)=> KidsCubit()..getMainSkillsData()
            ..getAudioData()
            ..getAudio2Data()..getAudio3Data()..getClapAudioData()
          ),
          BlocProvider(create: (context)=>appCubit()..changeAudio(fromShared: audioPlay))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor:  Color(0xFF252c4a),
              selectedItemColor: Colors.amber,
              unselectedItemColor: Colors.cyan,

            )

          ),
          // home: const FirstScreen(),
          home: uId!=null ?const KidsHomeScreen():const FirstScreen(),

        ));
  }
}


