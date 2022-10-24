// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'package:kids_app/shared/network/local/cach_helper.dart';
// import 'package:lottie/lottie.dart';
//
//
//
//
// class IGameHomeScreen extends StatefulWidget {
//   const IGameHomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<IGameHomeScreen> createState() => _GameHomeScreenState();
// }
//
// class _GameHomeScreenState extends State<IGameHomeScreen> {
//
//   AudioPlayer audioPlayer=AudioPlayer(),itemPlayer=AudioPlayer();
//   late List<ItemModel> items;
//   late List<ItemModel> item2;
//
//   late int score;
//   late bool gameOver;
//   int finish=0;
//
//   initGame(){
//     gameOver=false;
//     score=0;
//     finish=0;
//     items=[
//       ItemModel(name: 'اسد', image: 'assets/game/lion.png', value: 'اسد'),
//       ItemModel(name: 'باندا', image: 'assets/game/panda.png', value: 'باندا'),
//       ItemModel(name: 'جمل', image: 'assets/game/camel.png', value: 'جمل'),
//       ItemModel(name: 'كلب', image: 'assets/game/dog.png', value: 'كلب'),
//       ItemModel(name: 'قطه', image: 'assets/game/cat.png', value: 'قطه'),
//       ItemModel(name: 'حصان', image: 'assets/game/horse.png', value: 'حصان'),
//       ItemModel(name: 'خروف', image: 'assets/game/sheep.png', value: 'خروف'),
//       ItemModel(name: 'فرخه', image: 'assets/game/hen.png', value: 'فرخه'),
//      ItemModel(name: 'ثعلب', image: 'assets/game/fox.png', value: 'ثعلب'),
//      ItemModel(name: 'بقره', image: 'assets/game/cow.png', value: 'بقره'),
//     ];
//
//     item2=List<ItemModel>.from(items);
//
//     //display random
//     items.shuffle();
//     item2.shuffle();
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initGame();
//     audioPlayer.setSourceUrl(HomeCubit.get(context).clapAudio!.audio);
//
//     if(gameOver)
//       {
//         setState(() {
//
//         });
//       }
//     if(!gameOver){
//       setState(() {
//         audioPlayer.pause();
//       });
//
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     if(items.isEmpty)
//       {
//         gameOver=true;
//         audioPlayer.resume();
//       }
//     else{
//       audioPlayer.pause();
//     }
//     return SafeArea(child: SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           children:  [
//             Center(
//               child: Text.rich(
//                 TextSpan(
//                   children: [
//                     const TextSpan(
//                       text: 'Score',
//                       style: TextStyle(
//                         fontSize: 25,
//                         color: Colors.red
//                       )
//                     ),
//                     TextSpan(
//                         text: '$score',
//                         style: const TextStyle(
//                             fontSize: 40,
//                             color: Colors.teal
//                         )
//                     )
//                   ]
//                 )
//               ),
//             ),
//             if(!gameOver)
//               Row(
//                 children:[
//                   const Spacer(),
//                   Column(
//                     children:  items.map((item) {
//                       return Container(
//                         margin:const  EdgeInsets.all(8),
//                         child: Draggable<ItemModel>(
//                           data: item,
//                           childWhenDragging: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             backgroundImage: AssetImage(item.image),
//                             radius: 50,
//                           ),
//                           feedback: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             backgroundImage: AssetImage(item.image),
//                             radius: 30,
//                           ),
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             backgroundImage: AssetImage(item.image),
//                             radius: 40,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   const Spacer(flex: 2,),
//                   Column(
//                     children:  item2.map((item) {
//                       return DragTarget<ItemModel>(
//                         onAccept: (receivedItem){
//                           if(item.value==receivedItem.value){
//                             setState(() {
//
//                               items.remove(receivedItem);
//                               item2.remove(item);
//                               score+=10;
//
//                               item.accepting=false;
//                             });
//
//                             // audioPlayer.resume();
//
//                           }else{
//                             setState(() {
//                               score-=5;
//                               item.accepting=false;
//
//                             });
//                           }
//                         },
//                           onWillAccept: (receivedItem){
//                             setState(() {
//                               item.accepting=true;
//
//                             });
//                           return true;
//                           },
//                           onLeave: (receivedItem){
//                           setState(() {
//                             item.accepting=false;
//                           });
//                           },
//                           builder:(context,acceptedItem,rejectedItem){
//                           return Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: item.accepting?Colors.grey[400]:Colors.grey[400]
//                             ),
//                             alignment: Alignment.center,
//                             height: MediaQuery.of(context).size.width/6.5,
//                             width: MediaQuery.of(context).size.width/3,
//                             margin: const  EdgeInsets.all(8),
//                             child: Text(
//                               item.name,
//                               style: const TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.bold
//                               ),
//                             ),
//                           );
//
//                           }
//                       );
//                     }).toList(),
//                   ),
//                   const Spacer()
//                 ]
//               ),
//             if(gameOver)
//               Center(
//                 child: Column(
//                   children:  [
//                     const Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text(
//                           'Game Over',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.red,
//                           fontSize: 25
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(result(),
//                       style:const TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold
//                       ),),
//                     ),
//
//                   ],
//                 ),
//               ),
//             if(gameOver)
//               Column(
//                   children: [
//                     SizedBox(
//                       height: 300,
//                       width: 300,
//                       child: Lottie.asset("assets/lottie/clapping.json"),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           color: Colors.teal,
//                           borderRadius: BorderRadius.circular(25)
//                       ),
//                       child: TextButton(
//                         onPressed: (){
//                           setState(() {
//                             initGame();
//                           });
//                         },
//                         child: const Text(
//                           'العب مرة اخري',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//
//
//
//           ],
//         ),
//       ),
//     ));
//   }
//   String result(){
//     if(score==100){
//
//       return 'أحسنت رأئع';
//     }
//     else{
//       return 'العب مرة اخري';
//     }
//
//   }
// }
