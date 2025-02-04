import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Containers/MyButtonRegister.dart';
import 'package:flutter_application_1/Containers/MytextField.dart';
import 'package:flutter_application_1/Containers/NormalButton.dart';
import 'package:flutter_application_1/UserData/UserData.dart';
import 'package:flutter_application_1/pages/Homepage.dart';
import 'package:flutter_application_1/pages/RegisterPage.dart';
import 'package:http/http.dart' as http;

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final TextEditingController _EmailController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();

  Future<void> LoginTopage() async {
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2/Flutter_project/DatabaseProcess/Login.php'),
        body: {
          'email': _EmailController.text.toString(),
          'password': _PasswordController.text.toString(),
        },
      );
      if (response.statusCode == 200) {
        Userdata userdata = Userdata();
        await userdata.initHive();
        await userdata.ClearBoxEmail();
        int user_id = int.parse(json.decode(response.body));
        print("User found successfully ");
        print("User_id returned : " + user_id.toString());
        userdata.SetEmail(_EmailController.text);
        userdata.SetPassword(_PasswordController.text);
        userdata.SetId(user_id);
        String emaildata = await userdata.GetEmail();
        _EmailController.clear();
        _PasswordController.clear();
        print("Email has been set : $emaildata");

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePageOrder()));
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              child: Container(
        padding: EdgeInsets.all(12),
        height: 450,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.indigo[400], borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                "Login Form",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 40,
              ),
              MyTextField(
                  Hint: "Enter your Email Please: ",
                  controllertext: _EmailController),
              SizedBox(
                height: 40,
              ),
              MyTextField(
                  Hint: "Enter your Password: ",
                  controllertext: _PasswordController),
              Row(
                children: [
                  Center(
                      child: MyButtonRegister(
                          hint: "register",
                          job: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          }))
                ],
              ),
              SizedBox(
                height: 40,
              ),
              MyNormalButton(Job: LoginTopage, hint: "Login")
            ],
          ),
        ),
      ))),
    );
  }
}
