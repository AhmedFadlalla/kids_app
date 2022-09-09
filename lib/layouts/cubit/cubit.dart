
import 'dart:io';

import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_app/layouts/cubit/state.dart';
import 'package:kids_app/models/audio_data.dart';
import 'package:kids_app/models/data_model.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:kids_app/models/main_skill_data_model.dart';
import 'package:kids_app/modulus/kid_home_screen.dart';
import 'package:kids_app/modulus/skill_details.dart';

import '../../modulus/game_screen/game_home_screen.dart';
import '../../modulus/quiz_screen.dart';
import '../../shared/styles/icon_broken.dart';

class KidsCubit extends Cubit<KidsState>{
    KidsCubit() : super(InitialKidsState());

    static KidsCubit get(context)=>BlocProvider.of(context);

    int currentIndex = 0;
    late  String videoUrl,audio,name,description;


    List<BottomNavigationBarItem> items = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسيه'),
      const BottomNavigationBarItem(icon: Icon(Icons.quiz_sharp), label: 'اسئله'),
      const BottomNavigationBarItem(icon: Icon(Icons.games), label: 'لعبة'),

    ];
    List<String> titles = ['الصفحة الرئيسيه', 'اسئله','لعبة'];

    void changeBottomNavIndex(int index,context) async{
      await audioPlayer.setSourceUrl(audioData2!.audio);
      if(index == 1){
        audioPlayer.resume();
      }
      else{
        audioPlayer.stop();
      }
      currentIndex = index;
      emit(KidsChangeBottomNavState());
    }
List<Color>colors=[
  Colors.red,
  Colors.green,
  Colors.pink,
  Colors.purple
];
//     // File? file;
//     // var picker = FilePicker.platform.pickFiles();
//     //
//     // Future<void> getVideo() async {
//     //     final pickedFile = await picker;
//     //     if (pickedFile != null) {
//     //         file = File(pickedFile.files.single.path!);
//     //         emit(PickFileSuccessfulState());
//     //     } else {
//     //         if (kDebugMode) {
//     //           print('No video selected');
//     //           emit(PickFileErrorState());
//     //         }
//     //
//     //     }
//     // }
//     //
//     //
//     //
//     // void uploadVideo(){
//     //     firebase_storage.FirebaseStorage
//     //         .instance
//     //         .ref().child('videos/${Uri.file(file!.path).pathSegments.last}')
//     //         .putFile(file!)
//     //         .then((value) {
//     //             value.ref.getDownloadURL().then((value) {
//     //
//     //               sendData(videos: value,audio: '');
//     //
//     //
//     //             });
//     //
//     //     }).catchError((error){
//     //       print(error.toString());
//     //       emit(UploadVideosErrorState(error.toString()));
//     //
//     //     });
//     //
//     // }
//
// //     void uploadAudio(){
// //       firebase_storage.FirebaseStorage
// //           .instance
// //           .ref().child('audio/${Uri.file(file!.path).pathSegments.last}')
// //           .putFile(file!)
// //           .then((value) {
// //         value.ref.getDownloadURL().then((value) {
// //
// //           sendAudio(audio: value);
// //           // updateData(audio: value);
// //         });
// //
// //       }).catchError((error){
// //         print(error.toString());
// //         emit(UploadVideosErrorState(error.toString()));
// //
// //       });
// //
// //     }
// //
// //
// //     void updateData({
// //   required String audio
// // }){
// //       SkillDataModel model=SkillDataModel(
// //           name: 'ادراة الوقت',
// //           image: 'https://cdn-icons-png.flaticon.com/512/4474/4474370.png',
// //           description: 'اياك ان تهدر وقتك',
// //           videos: 'https://firebasestorage.googleapis.com/v0/b/kids-project-962cf.appspot.com/o/videos%2F%D9%83%D8%A7%D8%B1%D8%AA%D9%88%D9%86%20%D8%AA%D8%B9%D9%84%D9%8A%D9%85%D9%8A%20%D8%A3%D9%87%D9%85%D9%8A%D8%A9%20%D8%A7%D9%84%D9%88%D9%82%D8%AA(360P).mp4?alt=media&token=5b99111f-fe47-4b21-9f28-64816fb55e10',
// //           audio: audio,
// //         skillAudio: 'https://firebasestorage.googleapis.com/v0/b/kids-project-962cf.appspot.com/o/audio%2F%D8%A5%D8%AF%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%88%D9%82%D8%AA%20.aac?alt=media&token=e0399b4d-b326-4ee9-ac52-cec860e1f512'
// //       );
// //       FirebaseFirestore.instance
// //           .collection('skills')
// //           .doc('Jm4lROjre6AC9qpnw0rt')
// //           .update(model.toMap()).then((value) {
// //             if (kDebugMode) {
// //               print("success");
// //             }
// //       });
// //     }
// //     void sendAudio({
// //       required String audio,
// //
// //     }){
// //
// //       AudioData audioData=AudioData(audio: audio);
// //       FirebaseFirestore.instance
// //           .collection('audio')
// //           .doc()
// //           .set(audioData.toMap())
// //           .then((value) {
// //         emit(AddSkillDataSuccessfulState());
// //       }).catchError((error){
// //         if (kDebugMode) {
// //           print(error.toString());
// //         }
// //         emit(AddSkillDataErrorState(error.toString()));
// //       });
// //     }
//     void sendData({
//         required String videos,
//       required String audio,
//
// }){
//
//         SkillDataModel model=SkillDataModel(
//             name: "ادراة الوقت",
//             image: "https://cdn-icons-png.flaticon.com/512/4474/4474370.png",
//             description: "اياك ان تهدر وقتك",
//             videos: videos,
//           audio: audio,
//           skillAudio: 'https://firebasestorage.googleapis.com/v0/b/kids-project-962cf.appspot.com/o/audio%2F%D8%A5%D8%AF%D8%A7%D8%B1%D8%A9%20%D8%A7%D9%84%D9%88%D9%82%D8%AA%20.aac?alt=media&token=e0399b4d-b326-4ee9-ac52-cec860e1f512'
//         );
//        FirebaseFirestore.instance
//            .collection('skills')
//            .doc()
//            .set(model.toMap())
//            .then((value) {
//                emit(AddSkillDataSuccessfulState());
//        }).catchError((error){
//          if (kDebugMode) {
//            print(error.toString());
//          }
//          emit(AddSkillDataErrorState(error.toString()));
//        });
//     }
    List<MainSkillDataModel> mainSkillsData=[];
getMainSkillsData(){
  mainSkillsData=[];
  FirebaseFirestore
      .instance
      .collection('skills')
      .snapshots()
      .listen((value) {
    for (var element in value.docs) {
      mainSkillsData.add(MainSkillDataModel.fromJson(element.data()));
    }
    emit(GetSkillDataSuccessfulState());
  });
}




   List<SkillDataModel> skillDataModel=[];
    void getSkillData({required String doc}){
      skillDataModel=[];
      FirebaseFirestore.instance.collection('skills').doc(doc).collection('collection')
          .snapshots()
          .listen((value) {
            for (var element in value.docs) {
              skillDataModel.add(SkillDataModel.fromJson(element.data()));
            }
            emit(GetSkillDataSuccessfulState());
      });
      
}

    List<AudioData>? audioData;
    void getAudioData(){
      FirebaseFirestore.instance.collection('audio')
          .snapshots()
          .listen((value) {

            value.docs.forEach((element) {

            });
        emit(GetSkillDataSuccessfulState());
      });

    }
    AudioData? audioData2;
    void getAudio2Data(){
      FirebaseFirestore.instance.collection('audio')
          .doc('mVZhEVwwODQnfSgBteUk')
          .get()
          .then((value) {
        audioData2=AudioData.fromJson(value.data()!);
        emit(GetSkillDataSuccessfulState());
      }).catchError((error){
        print(error.toString());
        emit(GetSkillDataErrorState(error.toString()));
      });

    }

    AudioData? audioData3;
    void getAudio3Data(){
      FirebaseFirestore.instance.collection('audio')
          .doc('uiZNR2yaCCjNIjQ9Zbdq')
          .get()
          .then((value) {
        audioData3=AudioData.fromJson(value.data()!);
        emit(GetSkillDataSuccessfulState());
      }).catchError((error){
        print(error.toString());
        emit(GetSkillDataErrorState(error.toString()));
      });

    }

    AudioData? clapAudio;
    void getClapAudioData(){
      FirebaseFirestore.instance.collection('audio')
          .doc('NrGv3aC4pVpjvqAyDQ7X')
          .get()
          .then((value) {
        clapAudio=AudioData.fromJson(value.data()!);
        emit(GetSkillDataSuccessfulState());
      }).catchError((error){
        print(error.toString());
        emit(GetSkillDataErrorState(error.toString()));
      });

    }

  AudioPlayer audioPlayer=AudioPlayer();
    String audioAssets='assets/audio/sound1.mp3';

  bool isPlaying=false;
  // void playSound()async{
  //   ByteData bytes = await rootBundle.load(audioAssets); //load sound from assets
  //   Uint8List  soundbytes = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
  //   // int result = await audioPlayer.playBytes(soundbytes);
  //   if(result == 1){ //play success
  //     print("Sound playing successful.");
  //   }else{
  //     print("Error while playing sound.");
  //   }
  // }




}