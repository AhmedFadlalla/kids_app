class AudioData{



  late String audio;

  AudioData({
    required this.audio,

  });

  AudioData.fromJson(Map<String, dynamic> json) {
    audio = json['audio'];

  }

  Map<String, dynamic> toMap() {
    return {
      'audio': audio,

    };
  }

}