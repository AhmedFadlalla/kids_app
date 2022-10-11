import 'package:dartz/dartz.dart';
import 'package:kids_app/core/error/failure.dart';

import '../entities/base_main_skill.dart';
abstract class BaseAppRepository {

  Future<Either<Failure,List<BaseMainSkillData>>> getMainSkillsData();
}