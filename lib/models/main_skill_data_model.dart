class MainSkillDataModel{

  final String name;
  final String audio;

  MainSkillDataModel({required this.name,required this.audio});

  factory MainSkillDataModel.fromJson(Map<String , dynamic>json)=>
      MainSkillDataModel(name: json["name"], audio:json["audio"] );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'audio': audio,
    };
  }
}