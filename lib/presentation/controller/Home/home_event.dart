import 'package:equatable/equatable.dart';

abstract class BaseHomeEvent extends Equatable{
  BaseHomeEvent();

  @override
  List<Object?> get props => [];
}

class GetMainSkillDataEvent extends BaseHomeEvent{}
class GetSkillDataEvent extends BaseHomeEvent{
  final String skillName;
  GetSkillDataEvent({
    required this.skillName
});
}
class GetSkillDetailsDataEvent extends BaseHomeEvent{
  final String skillName;
  final String skillName2;
  GetSkillDetailsDataEvent({
    required this.skillName,
    required this.skillName2
  });
}
class GetAudiosDataEvent extends BaseHomeEvent{}