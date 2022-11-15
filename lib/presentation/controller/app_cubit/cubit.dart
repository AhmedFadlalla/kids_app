import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_app/presentation/controller/app_cubit/states.dart';


import 'package:kids_app/shared/network/endpoints.dart';
import 'package:sqflite/sqflite.dart';

import '../../../shared/network/local/cach_helper.dart';



class appCubit extends Cubit<AppStates> {
  appCubit() : super(appInitialState());

  static appCubit get(BuildContext context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(appChangeIndex());
  }

  late Database database;

  // ignore: non_constant_identifier_names
  String TableName = 'tasks';

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];




  bool isButtomSheetShow = false;
  IconData FABIcaon = Icons.edit;

  void changeIcons({
    required bool isShow,
    required IconData icon,
  }) {
    isButtomSheetShow = isShow;
    FABIcaon = icon;

    emit(appChangeFabBottomIcon());
  }



  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(appChangeModeStates());
    } else {
      isDark = !isDark;
      CachHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(appChangeModeStates());
      });
    }
  }

  bool isPlay = true;

  void changeAudio({bool? fromShared}) {
    if (fromShared != null) {
      isPlay = fromShared;
      emit(appChangeModeStates());
    } else {
      isPlay = !isPlay;
      CachHelper.saveData(key: audio, value: isPlay).then((value) {
        emit(appChangeModeStates());
      });
    }
  }

}
