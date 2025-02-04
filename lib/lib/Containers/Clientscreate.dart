import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/ProductsPage.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ClientCreation extends StatefulWidget {
  int? personId;
  String? clientname;
  double? cost;
  bool? cheked;
  Function OpenClientsinfo;
  Function clientsCheked;

  ClientCreation({
    super.key,
    required this.clientname,
    required this.cost,
    required this.cheked,
    required this.OpenClientsinfo,
    required this.clientsCheked,
    required this.personId,
  });

  factory ClientCreation.fromJson(Map<String, dynamic> json) {
    return ClientCreation(
      personId: int.parse(json['personid']),
      clientname: json['clientname'].toString(),
      cost: double.parse(json['clientamount']),
      cheked: json["cheked"] == 1,
      OpenClientsinfo: () {},
      clientsCheked: () {},
    );
  }

  @override
  State<ClientCreation> createState() => _ClientCreationState();
}

class _ClientCreationState extends State<ClientCreation> {
  int boolConverter(bool c) {
    return c ? 1 : 0;
  }

  void chekerclient() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2/Flutter_project/DatabaseProcess/clientCheker'),
      body: {
        "cheked": boolConverter(widget.cheked!),
        "PersonId": widget.personId.toString(),
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        widget.cheked = !widget.cheked!;
      });
    } else {
      throw Exception('Failed to load orders');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 350,
          height: 70,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 198, 210, 219),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              SizedBox(width: 15),
              GestureDetector(
                onTap: () {
                  if (widget.personId != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductsPage(PersonId: widget.personId!),
                      ),
                    );
                  } else {
                    // Handle null personId case
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('No person ID available.')),
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 85,
                      child: Text(
                        widget.clientname ?? 'Unknown Client',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15),
              Container(
                width: 3,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Amount: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                width: 65,
                child: Text(widget.cost?.toString() ?? '0.0'),
              ),
              Checkbox(
                value: widget.cheked,
                onChanged: (bool? value) {
                  setState(() {
                    widget.cheked = value;
                    chekerclient();
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
