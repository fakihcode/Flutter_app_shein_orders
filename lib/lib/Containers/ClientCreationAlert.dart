import 'package:flutter/material.dart';
import 'package:flutter_application_1/Containers/MytextField.dart';
import 'package:flutter_application_1/Containers/NormalButton.dart';

// ignore: must_be_immutable
class ClientsAlertCreation extends StatelessWidget {
  TextEditingController nametextfield;
  TextEditingController amounttextfield;
  Function popoffwindow;
  Function createnewclient;
  ClientsAlertCreation(
      {super.key,
      required this.nametextfield,
      required this.popoffwindow,
      required this.createnewclient,
      required this.amounttextfield});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 240,
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
                "Create a client",
                style: TextStyle(fontSize: 22),
              ),
              MyTextField(
                  Hint: "Enter client name", controllertext: nametextfield),
              SizedBox(
                height: 20,
              ),
              MyTextField(
                  Hint: "Enter the amount voucher ",
                  controllertext: amounttextfield),
              Row(
                children: [
                  MyNormalButton(hint: "Cancel", Job: popoffwindow),
                  MyNormalButton(hint: "Create", Job: createnewclient),
                ],
              )
            ],
          ),
        ));
  }
}
