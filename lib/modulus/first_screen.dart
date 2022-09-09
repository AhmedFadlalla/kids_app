import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kids_app/layouts/cubit/cubit.dart';
import 'package:kids_app/layouts/cubit/state.dart';
import 'package:kids_app/layouts/kids_home_layout.dart';
import 'package:kids_app/modulus/kid_home_screen.dart';
import 'package:kids_app/shared/component/components.dart';
import 'package:kids_app/shared/network/local/cach_helper.dart';
import 'package:lottie/lottie.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController=TextEditingController();
    return BlocConsumer<KidsCubit,KidsState>(
        builder: (context,state){
      return Scaffold(

      backgroundColor: const Color(0xFF252c4a),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 25,),
            Center(
              child: SizedBox(
                height: 300,
                width: 300,
                child: Lottie.asset("assets/lottie/kids.json"),
              ),
            ),
            Text(
                'كن ايجابيا',
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                      fontSize: 70.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Rama'

                  ),
                )

            ),
            const SizedBox(height: 90,),
            SizedBox(
              width: 200,
              child: defaultButton(
                  function: (){
                    CachHelper.saveData(key: 'id', value: 1)
                        .then((value) {
                      navigateTo(context, const KidsHomeScreen());
                    });

                  },
                  text: 'دخول'),
            )



          ],
        ),
      ),
    );},
        listener: (context,state){}
    );
  }
}
