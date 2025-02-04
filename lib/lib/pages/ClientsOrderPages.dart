import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Containers/ClientCreationAlert.dart';
import 'package:flutter_application_1/Containers/Clientscreate.dart';
import 'package:flutter_application_1/Lists/ClientsList/DataNodeClient.dart';
import 'package:flutter_application_1/Lists/ClientsList/clientList.dart';
import 'package:flutter_application_1/pages/Homepage.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Clientsorderpage extends StatefulWidget {
  String Order_id;
  Clientsorderpage({super.key, required this.Order_id});

  @override
  State<Clientsorderpage> createState() => _ClientsorderpageState();
}

class _ClientsorderpageState extends State<Clientsorderpage> {
  ClientList Listclient = new ClientList();
  TextEditingController amountTextfield = TextEditingController();
  TextEditingController clientnameTextfield = TextEditingController();

  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    fetchClients();
    print("there is :  " + Listclient.CountClients().toString() + " clients");
  }

  Future<void> insertClient() async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://10.0.2.2/Flutter_project/DatabaseProcess/newClient.php'),
        body: {
          "amount": amountTextfield.text,
          "finished": "0",
          "orderid": widget.Order_id,
          "clientname": clientnameTextfield.text,
        },
      );
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        fetchClients();
        print("client successfully inserted");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  void createnewwindow() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: ClientsAlertCreation(
                nametextfield: clientnameTextfield,
                popoffwindow: popoff,
                createnewclient: insertClient,
                amounttextfield: amountTextfield),
          );
        });
  }

  void createandfetch() {
    insertClient();
    popoff();
  }

  void popoff() {
    Navigator.of(context).pop();
    clientnameTextfield.clear();
    amountTextfield.clear();
  }

  void fetchClients() async {
    Listclient.MakeEmpty();
    final response = await http.post(
        Uri.parse(
            'http://10.0.2.2/Flutter_project/DatabaseProcess/GetClientsOrder.php'),
        body: {
          "Order_id": widget.Order_id,
        });

    if (response.statusCode == 200) {
      print("fetch Starting...");
      setState(() {
        List<dynamic> jsonList = json.decode(response.body);
        List<ClientCreation> clients =
            jsonList.map((json) => ClientCreation.fromJson(json)).toList();
        for (int x = 0; x < clients.length; x++) {
          Datanodeclient cd = Datanodeclient(client: clients[x]);
          Listclient.AddClient(cd);
        }
      });
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    Listclient.printClients();

    print(Listclient.CountClients());

    if (Listclient.CountClients() == 0) {
      return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("client's")),
        ),
        floatingActionButton: FloatingActionButton(onPressed: createnewwindow),
        body: Center(
          child: Text("there is no client in this order"),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      (MaterialPageRoute(
                          builder: (context) => HomePageOrder())));
                },
                child: Icon(
                  Icons.arrow_circle_left,
                  size: 35,
                ),
              ),
              SizedBox(
                width: 115,
              ),
              Text("Client's")
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: createnewwindow),
        body: ListView.builder(
          itemCount: Listclient.CountClients(),
          itemBuilder: (context, index) {
            return ClientCreation(
                clientname: Listclient.GetClientAt(index)?.clientname,
                cost: Listclient.GetClientAt(index)?.cost,
                cheked: Listclient.GetClientAt(index)?.cheked,
                OpenClientsinfo: () {},
                clientsCheked: () {},
                personId: Listclient.GetClientAt(index)?.personId);
          },
        ),
      );
    }
  }
}
