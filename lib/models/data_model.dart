class SkillDataModel{
  late String name;
  late String image;
  late String description;
  late String videos;
  late String audio;
  late String skillAudio;

  SkillDataModel({
    required this.name,
    required this.image,
    required this.description,
    required this.videos,
    required this.audio,
    required this.skillAudio,
  });

  SkillDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    description = json['description'];
    videos = json['videos'];
    audio = json['audio'];
    skillAudio = json['skillAudio'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'videos': videos,
      'audio': audio,
      'skillAudio': skillAudio,
    };
  }


}