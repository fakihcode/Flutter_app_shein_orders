import 'package:flutter/material.dart';
import 'package:flutter_application_1/Containers/MytextField.dart';
import 'package:flutter_application_1/Containers/NormalButton.dart';
import 'package:flutter_application_1/pages/LoginPage.dart';
//import 'package:flutter_application_1/pages/LoginPage.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _Emailcontroller = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();

  void tryi() {
    print("object");
  }

  Future<void> insertUser() async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://10.0.2.2/Flutter_project/DatabaseProcess/CreateUser.php'),
        body: {
          'email': _Emailcontroller.text.toString(),
          'password': _PasswordController.text.toString(),
        },
      );
      if (response.statusCode == 200) {
        print("User has been inserted" +
            _Emailcontroller.text.toString() +
            " " +
            _PasswordController.text.toString());

        _Emailcontroller.clear();
        _PasswordController.clear();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Loginpage()));
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
                "Register Form",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 40,
              ),
              MyTextField(
                  Hint: "Enter an Email Please",
                  controllertext: _Emailcontroller),
              SizedBox(
                height: 40,
              ),
              MyTextField(
                  Hint: "Enter a Password",
                  controllertext: _PasswordController),
              SizedBox(
                height: 40,
              ),
              MyNormalButton(Job: insertUser, hint: "Register"),
            ],
          ),
        ),
      ))),
    );
  }
}
