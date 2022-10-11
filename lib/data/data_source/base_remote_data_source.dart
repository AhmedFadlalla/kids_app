import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/main_skill_data_model.dart';

abstract class BaseRemoteDataSource {
  Future<List<BaseMainSkillDataModel>> getMainSkillsData();
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

}