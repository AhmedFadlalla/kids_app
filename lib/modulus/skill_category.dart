import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillCategory extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;
  final Color color;

  const SkillCategory({required this.imageUrl,required this.title,required this.description,required this.color, Key? key}) : super(key: key);

  @override
  State<SkillCategory> createState() => _SkillCategoryState();
}

class _SkillCategoryState extends State<SkillCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          Positioned(
            left: 50,
              child:Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                constraints: const BoxConstraints(maxWidth: 330,maxHeight: 200),
              )
          ),
          Positioned(
              top: 25,
              child:Hero(
              tag: 'my skill',
                transitionOnUserGestures: true,
                child: Image(
                  image: AssetImage(widget.imageUrl),
                  width: 150,
                  height: 150,
                ),
              )
          ),
          Positioned(
              left: 160,
              top: 25,
              child:Text(
                  widget.title,
                style: GoogleFonts.mochiyPopOne(
                  textStyle: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Rama'

                  ),
              )
          ),
          ),
          Positioned(
              top: 10,
              left: 160,
              child:Container(
                width: 200,
                height: 200,
                child: Opacity(
                  opacity: 0.8,
                  child: Center(
                    child: Text(
                        widget.description,
                      style: const TextStyle(
                        wordSpacing: 4,
                        fontFamily: 'Poppins',
                        fontSize: 22.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.white
                      ),
                    ),
                  ),

                ),
              )
          )
        ],
      ),
    );
  }
}
