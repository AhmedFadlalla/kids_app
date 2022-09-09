import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

class AudioAssetPlayer{
  final String fileName;

  final _progressStreamController=StreamController<double>();


  late final AudioPlayer _audioPlayer;
  late final StreamSubscription _progressSubscription;
  late final int _audioDuration;

  Stream<double> get progressStream=>_progressStreamController.stream;
  Stream<PlayerState> get stateStream=>_audioPlayer.onPlayerStateChanged;

  AudioAssetPlayer(this.fileName);

  Future<void> init() async{
    await _audioPlayer.play(AssetSource(fileName));


    await Future.delayed(const Duration(milliseconds: 200));
    _audioDuration=(await _audioPlayer.getDuration()) as int;

    await _audioPlayer.stop();


    _progressStreamController.add(0.0);


    _progressSubscription=_audioPlayer.onPositionChanged.listen((duration) {
      _progressStreamController.add(duration.inMicroseconds/_audioDuration);
    });
  }


  Future<void> dispose()=>Future.wait({
    _audioPlayer.dispose(),
    _progressSubscription.cancel(),
    _progressStreamController.close()
  });


  Future<void> play()=>_audioPlayer.resume();

  Future<void> pause()=>_audioPlayer.pause();

  Future<void> reset()async{
   await _audioPlayer.stop();
   _progressStreamController.add(0.0) ;
  }



}