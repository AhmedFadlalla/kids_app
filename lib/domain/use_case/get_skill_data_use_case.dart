import 'package:dartz/dartz.dart';
import 'package:kids_app/core/error/failure.dart';
import 'package:kids_app/core/use_case/base_use_case.dart';
import 'package:kids_app/core/utils/constrant.dart';
import 'package:kids_app/domain/entities/base_skill_data.dart';
import 'package:kids_app/domain/repo/base_app_repo.dart';

class GetSkillDataUseCase extends BaseUseCase<List<BaseSkillData>,SkillParameter>{
  final BaseAppRepository baseAppRepository;


  GetSkillDataUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, List<BaseSkillData>>> call(SkillParameter parameter) async{
   return await baseAppRepository.getSkillData(parameter);
  }

}