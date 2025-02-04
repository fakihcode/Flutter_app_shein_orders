import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  TextEditingController controllertext;
  String Hint;

  MyTextField({super.key, required this.Hint, required this.controllertext});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllertext,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: Colors.indigo),
        hintText: Hint,
        border: OutlineInputBorder(),
      ),
    );
  }
}
