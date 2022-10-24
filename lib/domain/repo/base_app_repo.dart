import 'package:dartz/dartz.dart';
import 'package:kids_app/core/error/failure.dart';

import '../../core/utils/constrant.dart';
import '../entities/base_audio.dart';
import '../entities/base_main_skill.dart';
import '../entities/base_skill_data.dart';
abstract class BaseAppRepository {

  Future<Either<Failure,List<BaseMainSkillData>>> getMainSkillsData();
  Future<Either<Failure,List<BaseSkillData>>> getSkillData(SkillParameter parameter);
  Future<Either<Failure,BaseSkillData>> getSkillDetailsData(SkillParameter parameter);
  Future<Either<Failure,List<BaseAudioData>>> getAudiosData();
}