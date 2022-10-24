import 'package:dartz/dartz.dart';
import 'package:kids_app/core/error/failure.dart';
import 'package:kids_app/core/use_case/base_use_case.dart';
import 'package:kids_app/core/utils/constrant.dart';
import 'package:kids_app/domain/entities/base_skill_data.dart';
import 'package:kids_app/domain/repo/base_app_repo.dart';

class GetSkillDetailsDataUseCase extends BaseUseCase<BaseSkillData,SkillParameter>{
  final BaseAppRepository baseAppRepository;

  GetSkillDetailsDataUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, BaseSkillData>> call(SkillParameter parameter) async{
   return await baseAppRepository.getSkillDetailsData(parameter);
  }


}