import 'package:dartz/dartz.dart';
import 'package:kids_app/core/error/failure.dart';
import 'package:kids_app/core/use_case/base_use_case.dart';
import 'package:kids_app/domain/repo/base_app_repo.dart';

import '../entities/base_audio.dart';

class GetAudioDataUseCase extends BaseUseCase<List<BaseAudioData>,NoParameters>{
  final BaseAppRepository baseAppRepository;


  GetAudioDataUseCase(this.baseAppRepository);

  @override
  Future<Either<Failure, List<BaseAudioData>>> call(NoParameters parameter) async{
    return await baseAppRepository.getAudiosData();
  }

}