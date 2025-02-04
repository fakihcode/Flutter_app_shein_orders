import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/ClientsOrderPages.dart';

// ignore: must_be_immutable
class OrderCreation extends StatefulWidget {
  String OrderNumber;
  double Cost;
  bool OrderCompleted;
  String OrderName;

  OrderCreation(
      {super.key,
      required this.Cost,
      required this.OrderNumber,
      required this.OrderCompleted,
      required this.OrderName});

  factory OrderCreation.fromJson(Map<String, dynamic> json) {
    return OrderCreation(
      OrderName: json['OrderName'].toString(),
      Cost: double.parse(json['TotalPrice'].toString()),
      OrderNumber: json['OrderId'].toString(),
      OrderCompleted: int.parse(json['Finished']) == 1,
    );
  }

  @override
  State<OrderCreation> createState() => _OrderCreationState();
}

class _OrderCreationState extends State<OrderCreation> {
  void AccestoClients() {
    print("Accessing to order+id : " + widget.OrderNumber);
    Navigator.pushReplacement(
        context,
        (MaterialPageRoute(
            builder: (context) =>
                Clientsorderpage(Order_id: widget.OrderNumber))));
  }

   
  
  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.OrderName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                widget.Cost.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Bottom Row with Checkbox and Button
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Checkbox with an icon background
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.person, // Background icon for checkbox
                      size: 48,
                      color: Colors.white.withOpacity(0.3), // Faded icon
                    ),
                    Checkbox(
                      value: widget.OrderCompleted,
                      onChanged: (value) {
                        
                      },
                      activeColor: Colors.white, // Checkbox color
                      checkColor: Colors.blueAccent, // Checkmark color
                    ),
                  ],
                ),
                // Person button
                GestureDetector(
                  onTap: () => AccestoClients(),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.white, // Button background
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.person, // Icon for button
                      size: 32,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
