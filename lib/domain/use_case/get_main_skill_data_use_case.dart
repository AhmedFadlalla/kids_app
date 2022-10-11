import 'package:dartz/dartz.dart';
import 'package:kids_app/core/error/failure.dart';
import 'package:kids_app/core/use_case/base_use_case.dart';
import 'package:kids_app/domain/entities/base_main_skill.dart';
import 'package:kids_app/domain/repo/base_app_repo.dart';

class GetMainSkillDataUseCase extends BaseUseCase<List<BaseMainSkillData>,NoParameters>{
  final BaseAppRepository baseAppRepository;


  GetMainSkillDataUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, List<BaseMainSkillData>>> call(NoParameters parameter) async{
    return await baseAppRepository.getMainSkillsData();
  }

}