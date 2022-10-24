import 'package:equatable/equatable.dart';

class BaseSkillData extends Equatable{
  final String name;
  final String image;
  final String description;
  final String videos;
  final String audio;
  final String skillAudio;
  final String conversation;
  final String masrah;


  BaseSkillData({
    required this.name,
    required this.image,
    required this.description,
    required this.videos,
    required this.audio,
    required this.skillAudio,
    required this.conversation,
    required this.masrah
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    name,image,description,videos,audio,skillAudio,
    conversation,masrah
  ];
  
  
}