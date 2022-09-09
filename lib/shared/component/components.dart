
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../styles/icon_broken.dart';



Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required var function,
  required String text,
  var fontSize,
  bool isUpperCase = true,
  double radius = 10.0,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: Color(0xFF4DB6AC),
      ),
    );
Widget defaultTextButton({
  required String text,
  required var pressedFunction
})=>TextButton(
    onPressed: pressedFunction,
    child: Text(
        text.toUpperCase(),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15
      ),
    )
);
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  var onsubmit,
  var onChange,
  var onTap,
  String? hintText,
  var prefixIconTapFunction,
  required var validator,
   String? label,
  required IconData prefixIcon,
  var suffixIcon,
  bool isPassword = false,
  var sufixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onsubmit,
      onChanged: onChange,
      validator: validator,
      obscureText: isPassword,
      onTap: onTap,
      style: const TextStyle(
          color: Colors.white,
      ),

      decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Colors.white
          ),
          labelStyle: const TextStyle(
            color: Colors.white
          ),
          prefixIcon: InkWell(
            onTap: prefixIconTapFunction,
            child: Icon(
              prefixIcon,
            ),
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
              onPressed: sufixPressed,
              icon: Icon(
                suffixIcon,
              ))
              : null,

          enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Color(0xFF4DB6AC),

              )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.red,

              )
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.white,

              )
          )
      ),
    );



Widget defultLoginField({
  required TextEditingController controller,
  required TextInputType inputType,
  required String labelText,
  required IconData preIcon,
  required var tabFunction,
  required var validation,
}) =>
    TextFormField(
      decoration: InputDecoration(
        labelText: '$labelText',
        labelStyle: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,

        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),

        ),
        prefixIcon: Icon(
          preIcon,
        ),
      ),
      keyboardType: inputType,
      controller: controller,
      onTap: tabFunction,
      validator: validation,
    );

Widget materialBottomLogin({
  required var pressFunction,
  required String bottomText,
  Color backgroundColor = Colors.white24,
  double radius=20.0,
  double width=double.infinity,
  Color textColor=Colors.black,

}) {
  return Container(
    width: width,
    child: MaterialButton(
      onPressed: pressFunction,
      child: Text(
        '$bottomText',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, color:textColor ),
      ),


    ),

    decoration: BoxDecoration(

      borderRadius: BorderRadius.circular(radius),
      color: backgroundColor,



    ),

  );
}
Widget myDivider()=>Padding(
  padding: EdgeInsetsDirectional.only(start: 20.0),
  child:Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ) ,);


void navigateTo(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
        builder: (BuildContext context) =>widget

    )
);



void navigateAndFinish
    (context,widget)=>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context)=>widget),
            (Route<dynamic> route) => false);

void showToast({
  required String text,
  required ToastStates state
})=>  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}

Widget defaultAppBar(
    {
      required BuildContext context,
      var title,
      var actions
    }
    )=>AppBar(
  leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon:const Icon(IconBroken.Arrow___Left) ),
  title: Text('$title'),
  actions: [actions],
);


Widget BuildDropBottom(
    {required dropdownButtonTitle,
      required value,
      required function,
      required items}) =>
    Center(
      child: Container(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF4DB6AC)),
            borderRadius: BorderRadius.circular(5.0)),
        child: DropdownButton(
//elevation: 0,
            hint: Text(
              dropdownButtonTitle,
              style: TextStyle(
                fontSize: 18.0,
//fontWeight: FontWeight.bold,
              ),
            ),
            dropdownColor: Color(0xFFD4F8F5),
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 36,
            isExpanded: true,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              //textDirection: TextDirection.rtl, عايز اعمل ده
            ),
            value: value,
            onChanged: function,
            items: items),
      ),
    );

Widget defaultButton2({
  double width = double.infinity,
  double size = 25.0,
  double height = 60,
  Color background = Colors.blue,
  required var function,
  required String text,
  bool isUpperCase = true,
  double radius = 10.0,
  IconData icon = Icons.vaccines,
}) =>
    Container(
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 10.0,
          left: 10.0,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
              color: Colors.white,
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: MaterialButton(
                onPressed: function,
                child: Text(
                  isUpperCase ? text.toUpperCase() : text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );
Widget defaultRecordItem({
  required String txt,
}) =>
    Expanded(
      child: Material(
        elevation: 22.0,
        child: SizedBox(
          height: 60.0,
          child: Container(
            width: 150,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '${txt}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(color: Colors.red, spreadRadius: 0.5),
              ],
            ),
            height: 50,
          ),
        ),
      ),
    );
Widget defaultRecord({
  required String drName,
  required String horseState,
  required String horseDisease,
  required String DiseaseDate,
}) =>
    Row(
      children: [
        Expanded(child: defaultRecordItem(txt: '${drName}')),
        SizedBox(
          width: 3.0,
        ),
        Expanded(child: defaultRecordItem(txt: '${horseState}')),
        SizedBox(
          width: 3.0,
        ),
        Expanded(child: defaultRecordItem(txt: '${horseDisease}')),
        SizedBox(
          width: 3.0,
        ),
        Expanded(child: defaultRecordItem(txt: '${DiseaseDate}')),
        SizedBox(
          width: 3.0,
        ),
      ],
    );
Widget defaultfollowingMedicineItem({
  required String txt,
  required double height,
  required double width,
  required IconData icon,
  required String vaccine,
  required String date,
}) =>
    Material(
      elevation: 22.0,
      child: Container(
        width: width,
        height: height,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 5.0,
              ),
              Icon(
                icon,
                size: 35,
              ),
              SizedBox(
                width: 15.0,
              ),
              Column(
                children: [
                  Text(
                    // '${txt}'
                    'vaccine : ${vaccine}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 2.0,
                  ),
                  Text(
                    // '${txt}'
                    'date : ${date}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.indigo,
          boxShadow: const [
            BoxShadow(color: Colors.white, spreadRadius: 1.0),
          ],
        ),
      ),
    );

Widget TestCard({

  String? title,
  //String image = 'https://www.photosmix.com/wp-content/uploads/2020/02/%D8%B5%D9%88%D8%B1-%D8%AC%D9%85%D9%8A%D9%84%D8%A9-%D8%AC%D8%AF%D8%A7-2020-%D8%B5%D9%88%D8%B1-%D8%AC%D9%85%D9%8A%D9%84%D8%A9-%D9%85%D9%83%D8%AA%D9%88%D8%A8-%D8%B9%D9%84%D9%8A%D9%87%D8%A7-%D9%83%D9%84%D8%A7%D9%85-%D8%AD%D9%84%D9%88-%D8%A7%D9%83%D8%AB%D8%B1-%D9%85%D9%86-100-%D8%B5%D9%88%D8%B1%D8%A9-%D8%AC%D8%AF%D9%8A%D8%AF%D8%A9-2.jpg',
  String image ='https://static.vecteezy.com/system/resources/previews/002/238/384/original/portrait-of-an-arabian-horse-head-on-a-black-background-illustration-vector.jpg',

}) =>
    SizedBox(
      // width:50 ,
      // height:200 ,
      child: Card(
        elevation: 22.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(

          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image(
                  image: NetworkImage(
                    image,
                  ),
                  width: double.infinity,
                  height: 200.0,
                  fit: BoxFit.cover,
                ),
                Container(
                  color: Colors.black.withOpacity(0.4),
                  padding: EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 10,
                  ),

                  width: double.infinity,
                  child: Text(
                    title ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ],

        ),
      ),
    );

Widget defaultbutton({required double width,required Color background,required Function function,required String text, double radius = 20.0,required double size})=>
    Container(
      width: width,
      child: MaterialButton(
        onPressed:function(),
        child: Text(text.toUpperCase(),style: TextStyle(fontSize: size,fontWeight: FontWeight.bold,color: Colors.white,),),),
      decoration: BoxDecoration(
        borderRadius:BorderRadius.circular(radius),
        color: background,
      ),
    );

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.text, this.color})
      : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xff6200ee),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Center(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      ),
    );
  }
}

