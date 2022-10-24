import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:kids_app/core/use_case/base_use_case.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/constrant.dart';
import '../../../core/utils/enum.dart';
import '../../../domain/use_case/get_audio_data_use_case.dart';
import '../../../domain/use_case/get_main_skill_data_use_case.dart';
import '../../../domain/use_case/get_skill_data_use_case.dart';
import '../../../domain/use_case/get_skill_details_data_use_case.dart';
import 'home_event.dart';
import 'home_state.dart';



class HomeBloc extends Bloc<BaseHomeEvent, HomeState> {
  final GetMainSkillDataUseCase getMainSkillDataUseCase;
  final GetSkillDataUseCase getSkillDataUseCase;
  final GetSkillDetailsDataUseCase getSkillDetailsDataUseCase;
  final GetAudioDataUseCase getAudioDataUseCase;
  HomeBloc(this.getMainSkillDataUseCase,
      this.getSkillDataUseCase,
      this.getSkillDetailsDataUseCase,
      this.getAudioDataUseCase
      ) : super(HomeState()) {
    on<GetMainSkillDataEvent>((event, emit) async{
      final result=await getMainSkillDataUseCase(const NoParameters());
      result.fold((l) => emit(
        state.copyWith(
          mainSkillDataState: RequestState.error,
          mainSkillDataMessage: l.message
        )
      ), (r) => emit(
        state.copyWith(
          mainSkillData: r,
          mainSkillDataState: RequestState.loaded
        )
      ));
    });
    on<GetSkillDataEvent>((event, emit) async{
      final result=await getSkillDataUseCase(SkillParameter(skillName: event.skillName));

      result.fold((l) => emit(
          state.copyWith(
              skillDataState: RequestState.error,
              skillDataMessage: l.message
          )
      ), (r) => emit(
          state.copyWith(
              skillData: r,
              skillDataState: RequestState.loaded
          )
      ));
    });
    on<GetSkillDetailsDataEvent>((event, emit) async{
      final result=await getSkillDetailsDataUseCase(
          SkillParameter(
              skillName: event.skillName,
            skillName2: event.skillName2
          ));

      result.fold((l) => emit(
          state.copyWith(
              skillDetailsDataState: RequestState.error,
              skillDetailsDataMessage: l.message
          )
      ), (r) => emit(
          state.copyWith(
              skillDetailsData: r,
              skillDetailsDataState: RequestState.loaded
          )
      ));
    });
    on<GetAudiosDataEvent>((event, emit) async{
      final result=await getAudioDataUseCase(
          const NoParameters());

      result.fold((l) => emit(
          state.copyWith(
              audiosDataState: RequestState.error,
              audiosDataMessage: l.message
          )
      ), (r) => emit(
          state.copyWith(
              audiosData: r,
              audiosDataState: RequestState.loaded
          )
      ));
    });

  }
}
