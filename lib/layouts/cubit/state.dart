abstract class KidsState{}
class InitialKidsState extends KidsState{}

class PickFileSuccessfulState extends KidsState{}
class PickFileErrorState extends KidsState{}

class UploadVideosSuccessfulState extends KidsState{}
class UploadVideosErrorState extends KidsState{
  final String error;
  UploadVideosErrorState(this.error);
}

class AddSkillDataSuccessfulState extends KidsState{}
class AddSkillDataErrorState extends KidsState{
  final String error;
  AddSkillDataErrorState(this.error);
}

class GetSkillDataSuccessfulState extends KidsState{}
class GetSkillDataErrorState extends KidsState{
  final String error;
  GetSkillDataErrorState(this.error);
}
class KidsChangeBottomNavState extends KidsState{}