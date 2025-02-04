import 'package:flutter/material.dart';
import 'package:flutter_application_1/Containers/MytextField.dart';
import 'package:flutter_application_1/Containers/NormalButton.dart';

// ignore: must_be_immutable
class Ordercreationalert extends StatelessWidget {
  final TextEditingController OrderCreationName;
  Function popoffwindow;
  Function CreateFunction;

  Ordercreationalert({
    super.key,
    required this.OrderCreationName,
    required this.popoffwindow,
    required this.CreateFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 200,
        decoration:
            BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255)),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Create a new Order",
                style: TextStyle(fontSize: 22),
              ),
              MyTextField(
                  Hint: "Enter order name", controllertext: OrderCreationName),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  MyNormalButton(hint: "Cancel", Job: popoffwindow),
                  MyNormalButton(hint: "Create", Job: CreateFunction),
                ],
              )
            ],
          ),
        ));
  }
}
