import '../../domain/entities/base_audio.dart';

class AudioDataModel extends BaseAudioData {
  AudioDataModel({required String name, required String audio})
      : super(name: name, audio: audio);


  factory AudioDataModel.fromJson(Map<String,dynamic>json)
  =>AudioDataModel(name: json["name"], audio: json["audio"]);
}
