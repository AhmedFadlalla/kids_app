import 'package:equatable/equatable.dart';

class BaseAudioData extends Equatable{
  final String name;
  final String audio;


  BaseAudioData({
  required  this.name,
    required  this.audio});

  @override
  // TODO: implement props
  List<Object?> get props => [
    name,audio
  ];

}