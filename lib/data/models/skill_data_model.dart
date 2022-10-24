import '../../domain/entities/base_skill_data.dart';

class BaseSkillDataModel extends BaseSkillData {
  BaseSkillDataModel(
      {required String name,
      required String image,
      required String description,
      required String videos,
      required String audio,
      required String skillAudio,
        required String conversation,
        required String masrah,
      })
      : super(
            name: name,
            image: image,
            description: description,
            videos: videos,
            audio: audio,
            skillAudio: skillAudio,
    conversation: conversation,
    masrah: masrah
  );

  factory BaseSkillDataModel.fromJson(Map<String, dynamic> json) {
    return BaseSkillDataModel(
        name: json['name'],
        image: json['image'],
        description: json['description'],
        videos: json['videos'],
        audio: json['audio'],
        skillAudio: json['skillAudio'],
      conversation: json["conversation"],
      masrah: json["masrah"]
    );
  }
}
