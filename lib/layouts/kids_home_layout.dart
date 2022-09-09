import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kids_app/shared/component/constants.dart';

import '../modulus/bacman_game/bacman_game_home_screen.dart';
import '../modulus/game_screen/game_home_screen.dart';
import '../modulus/quiz_screen.dart';
import '../modulus/skill_details.dart';
import '../shared/network/local/cach_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class KidsHomeScreenLayouts extends StatefulWidget {
  final  int? currentIndex;
  const KidsHomeScreenLayouts({Key? key,this.currentIndex}) : super(key: key);

  @override
  State<KidsHomeScreenLayouts> createState() => _KidsHomeScreenLayoutsState();
}

class _KidsHomeScreenLayoutsState extends State<KidsHomeScreenLayouts> {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<KidsCubit,KidsState>(

        builder: (context,state){
          uId ??= CachHelper.getData(key: 'name');
          var cubit=KidsCubit.get(context);
          if (widget.currentIndex!=null){
            cubit.currentIndex=widget.currentIndex!;
          }
          List<Widget> screens = [

            SkillDetailsScreen(KidsCubit.get(context).videoUrl,
                KidsCubit.get(context).audio,KidsCubit.get(context).name, KidsCubit.get(context).description),
            const QuizScreen(),
            const GameHomeScreen(),

          ];

          return Scaffold(
            backgroundColor: const Color(0xFF252c4a),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color(0xFF252c4a).withOpacity(0.1)
              ),


              child: BottomNavigationBar(

                items: cubit.items,
                currentIndex: cubit.currentIndex,
                onTap: (index){
                  cubit.changeBottomNavIndex(index,context);
                },
              ),
            ),
            body: screens[cubit.currentIndex],

          );
        },
        listener: (context,state){});
  }
}
