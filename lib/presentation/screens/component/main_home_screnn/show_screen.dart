import 'package:flutter/material.dart';

class ShowScreen extends StatelessWidget {
  final String video;

  const ShowScreen({
    Key? key,
    required this.video
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text("Show"),
    );
  }
}
