import 'package:equatable/equatable.dart';
import 'package:kids_app/core/utils/enum.dart';

import '../../../domain/entities/base_audio.dart';
import '../../../domain/entities/base_main_skill.dart';
import '../../../domain/entities/base_skill_data.dart';

class HomeState extends Equatable {
  final List<BaseMainSkillData> mainSkillData;
  final RequestState mainSkillDataState;
  final String mainSkillDataMessage;
  final List<BaseSkillData> skillData;
  final RequestState skillDataState;
  final String skillDataMessage;
  final BaseSkillData? skillDetailsData;
  final RequestState skillDetailsDataState;
  final String skillDetailsDataMessage;
  final List<BaseAudioData> audiosData;
  final RequestState audiosDataState;
  final String audiosDataMessage;

  HomeState(
      {this.mainSkillData = const [],
      this.mainSkillDataState = RequestState.loading,
      this.mainSkillDataMessage = '',
      this.skillData = const [],
      this.skillDataState = RequestState.loading,
      this.skillDataMessage = '',
      this.skillDetailsData,
      this.skillDetailsDataState = RequestState.loading,
      this.skillDetailsDataMessage = '',
      this.audiosData = const [],
      this.audiosDataState = RequestState.loading,
      this.audiosDataMessage = ''});

  HomeState copyWith({
    List<BaseMainSkillData>? mainSkillData,
    RequestState? mainSkillDataState,
    String? mainSkillDataMessage,
    List<BaseSkillData>? skillData,
    RequestState? skillDataState,
    String? skillDataMessage,
    BaseSkillData? skillDetailsData,
    RequestState? skillDetailsDataState,
    String? skillDetailsDataMessage,
    List<BaseAudioData>? audiosData,
    RequestState? audiosDataState,
    String? audiosDataMessage,
  }) {
    return HomeState(
      mainSkillData: mainSkillData ?? this.mainSkillData,
      mainSkillDataState: mainSkillDataState ?? this.mainSkillDataState,
      mainSkillDataMessage: mainSkillDataMessage ?? this.mainSkillDataMessage,
      skillData: skillData ?? this.skillData,
      skillDataState: skillDataState ?? this.skillDataState,
      skillDataMessage: skillDataMessage ?? this.skillDataMessage,
      skillDetailsData: skillDetailsData ?? this.skillDetailsData,
      skillDetailsDataState:
          skillDetailsDataState ?? this.skillDetailsDataState,
      skillDetailsDataMessage:
          skillDetailsDataMessage ?? this.skillDetailsDataMessage,
      audiosData: audiosData??this.audiosData,
      audiosDataState: audiosDataState??this.audiosDataState,
      audiosDataMessage: audiosDataMessage??this.audiosDataMessage
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        mainSkillData,
        mainSkillDataState,
        mainSkillDataMessage,
        skillData,
        skillDataState,
        skillDataMessage,
        skillDetailsData,
        skillDetailsDataState,
        skillDetailsDataMessage,
    audiosData,audiosDataState,audiosDataMessage
      ];
}
