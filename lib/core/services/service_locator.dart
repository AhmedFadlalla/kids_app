
import 'package:get_it/get_it.dart';
import 'package:kids_app/data/data_source/base_remote_data_source.dart';
import 'package:kids_app/domain/repo/base_app_repo.dart';
import 'package:kids_app/domain/use_case/get_main_skill_data_use_case.dart';
import 'package:kids_app/domain/use_case/get_skill_details_data_use_case.dart';
import 'package:kids_app/presentation/controller/Home/home_bloc.dart';
import 'package:kids_app/presentation/controller/Home/home_event.dart';

import '../../data/repo/app_repo.dart';
import '../../domain/use_case/get_audio_data_use_case.dart';
import '../../domain/use_case/get_skill_data_use_case.dart';
final sl=GetIt.instance;
class ServicesLocator{
  void init(){
    //Bloc

    sl.registerFactory<HomeBloc>(() => HomeBloc(sl(),sl(),sl(),sl()));
    // كل ما بنادي ع بلوك هيعمل نيو اوبجكت علشان يجيب الداتا جديده
    //use case
    sl.registerLazySingleton<GetMainSkillDataUseCase>(() => GetMainSkillDataUseCase(sl()));
    sl.registerLazySingleton<GetSkillDataUseCase>(() => GetSkillDataUseCase(sl()));
    sl.registerLazySingleton<GetSkillDetailsDataUseCase>(() => GetSkillDetailsDataUseCase(sl()));
    sl.registerLazySingleton<GetAudioDataUseCase>(() => GetAudioDataUseCase(sl()));
    //Repository

    sl.registerLazySingleton<BaseAppRepository>(() => AppRepository(sl()));
    //data source

    sl.registerLazySingleton<BaseRemoteDataSource>(() =>RemoteDataSource() );
  }

}