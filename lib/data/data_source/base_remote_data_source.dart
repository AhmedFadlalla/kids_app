import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kids_app/core/utils/constrant.dart';
import 'package:kids_app/data/models/skill_data_model.dart';

import '../models/audio_data_model.dart';
import '../models/main_skill_data_model.dart';

abstract class BaseRemoteDataSource {
  Future<List<BaseMainSkillDataModel>> getMainSkillsData();
  Future<List<BaseSkillDataModel>> getSkillDData(SkillParameter parameter);
  Future<BaseSkillDataModel> getSkillDetailsData(SkillParameter parameter);
  Future<List<AudioDataModel>> getAudiosData();
}

class RemoteDataSource extends BaseRemoteDataSource{
  @override
  Future<List<BaseMainSkillDataModel>> getMainSkillsData() async{
    return await FirebaseFirestore
        .instance
        .collection('skills')
        .get()
        .then((value) {
       return value.docs.map((e) {
        return  BaseMainSkillDataModel.fromJson(e.data());
      }).toList();

    });
  }

  @override
  Future<List<BaseSkillDataModel>> getSkillDData(SkillParameter parameter)async {
    return FirebaseFirestore.instance
        .collection('skills')
        .doc(parameter.skillName)
        .collection('collection')
        .get()
        .then((value) {
      return value.docs.map((e) {
        return  BaseSkillDataModel.fromJson(e.data());
      }).toList();
    });
  }

  @override
  Future<BaseSkillDataModel> getSkillDetailsData(SkillParameter parameter)async {
    return FirebaseFirestore.instance
        .collection('skills')
        .doc(parameter.skillName)
        .collection('collection').
         doc(parameter.skillName2)
        .get()
        .then((value) {
          return BaseSkillDataModel.fromJson(value.data()!);
    });
  }

  @override
  Future<List<AudioDataModel>> getAudiosData() async{
  return await FirebaseFirestore.instance
      .collection('audio')
      .get()
      .then((value) {
        return value.docs.map((e) {
          return AudioDataModel.fromJson(e.data());
        }).toList();
  });
  }

}