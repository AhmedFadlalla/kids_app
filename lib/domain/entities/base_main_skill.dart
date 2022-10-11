import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
class BaseMainSkillData extends Equatable{
  final String name;
  final String audio;

  BaseMainSkillData({required this.name,required this.audio});

  @override
  // TODO: implement props
  List<Object?> get props => [
    name,audio
  ];
}