




import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

import '../network/local/cach_helper.dart';

List<Map> tasks=[];

void signOut(context){
  CachHelper.removeData(key: 'token').then((value) {
    if(value){
      // navigateTo(context, ShopLoginScreen());
    }

  });
}

void printFullText(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) =>print(match.group(0)));

}
String token='';



int? uId;
AudioPlayer mainAudioPlayer=AudioPlayer();
bool isFinished=false;

bool? audioPlay;

//baseUrl: http://newsapi.org/
// methode: v2/top-headlines?
// quires: country=eg&category=business&apiKey=6548987cacc64a19a4e82084fce1b2fe


//https://newsapi.org/
// v2/everything?
// q=tesla&apiKey=6548987cacc64a19a4e82084fce1b2fe