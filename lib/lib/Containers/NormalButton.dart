import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyNormalButton extends StatelessWidget {
  String hint;
  Function? Job;
  MyNormalButton({super.key, required this.Job, required this.hint});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Job!(),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            hint,
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
        ),
        height: 40,
        width: 100,
      ),
    );
  }
}
