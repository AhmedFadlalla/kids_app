import 'package:dartz/dartz.dart';
import 'package:kids_app/core/error/failure.dart';
import 'package:kids_app/core/utils/constrant.dart';
import 'package:kids_app/data/data_source/base_remote_data_source.dart';
import 'package:kids_app/domain/entities/base_audio.dart';
import 'package:kids_app/domain/entities/base_main_skill.dart';
import 'package:kids_app/domain/entities/base_skill_data.dart';
import 'package:kids_app/domain/repo/base_app_repo.dart';

class AppRepository extends BaseAppRepository{
  final BaseRemoteDataSource baseRemoteDataSource;
  AppRepository(this.baseRemoteDataSource);
  @override
  Future<Either<Failure, List<BaseMainSkillData>>> getMainSkillsData() async{
    final result=await baseRemoteDataSource.getMainSkillsData();
    try{
      return  Right(result);
    }on ServerFailure catch(failure){
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, List<BaseSkillData>>> getSkillData(SkillParameter parameter) async{
    final result=await baseRemoteDataSource.getSkillDData(parameter);
    try{
      return  Right(result);
    }on ServerFailure catch(failure){
      return Left(ServerFailure(failure.message));
    }
  }

  @override
  Future<Either<Failure, BaseSkillData>> getSkillDetailsData(SkillParameter parameter) async{
    final result=await baseRemoteDataSource.getSkillDetailsData(parameter);
    try{
      return  Right(result);
    }on ServerFailure catch(failure){
      return Left(ServerFailure(failure.message));
    }

  }

  @override
  Future<Either<Failure, List<BaseAudioData>>> getAudiosData()async {
 final result=await baseRemoteDataSource.getAudiosData();
 try{
   return  Right(result);
 }on ServerFailure catch(failure){
   return Left(ServerFailure(failure.message));
 }
  }

}