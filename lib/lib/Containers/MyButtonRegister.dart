import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButtonRegister extends StatelessWidget {
  String hint;
  Function? job;

  MyButtonRegister({super.key, required this.hint, required this.job});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => job!(),
      child: Container(
        child: Text(hint),
        height: 20,
        width: 50,
      ),
    );
  }
}
