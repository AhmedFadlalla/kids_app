import 'package:kids_app/domain/entities/base_main_skill.dart';

class BaseMainSkillDataModel extends BaseMainSkillData{
  BaseMainSkillDataModel({
    required String name,
    required String audio}) :
        super(name: name, audio: audio);

  factory BaseMainSkillDataModel.fromJson(Map<String,dynamic>json){
    return BaseMainSkillDataModel(name: json["name"], audio: json["audio"]);
  }

}