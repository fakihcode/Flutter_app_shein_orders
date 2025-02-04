import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Containers/Order.dart';
import 'package:flutter_application_1/Containers/OrderCreationAlert.dart';
import 'package:flutter_application_1/Lists/ClientsList/OrderList/DataNode.dart';
import 'package:flutter_application_1/Lists/ClientsList/OrderList/OrderList.dart';
import 'package:flutter_application_1/UserData/UserData.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class HomePageOrder extends StatefulWidget {
  HomePageOrder({super.key});

  @override
  State<HomePageOrder> createState() => _HomePageOrderState();
}

class _HomePageOrderState extends State<HomePageOrder> {
  Orderlist Listorder = new Orderlist();
  Userdata user_data = new Userdata();
  TextEditingController OrderNameTextfield = TextEditingController();
  String? email;
  int? User_id;

  @override
  void initState() {
    super.initState();
    loadData();
  }
//---------------------------------

  Future<void> loadData() async {
    String? userEmail = await GetEmailUser();
    int? UserId = await GetUserId();
    setState(() {
      email = userEmail;
      User_id = UserId;
    });
    fetchOrders();
  }

//--------------------------------------

  Future<String> GetEmailUser() async {
    await user_data.initHive();
    return user_data.GetEmail();
  }
  //--------------------------------------

  //--------------------------------------

  void PrintinfoBeforeCreation() {
    print("OrderInformation: " +
        "\n Total Price: 0" +
        "\nComplitation : false " +
        "\n UserId :" +
        User_id.toString() +
        "\n order Name: " +
        OrderNameTextfield.text);
  }
  //-----------------------------------------------------

  Future<int> GetUserId() async {
    await user_data.initHive();
    return user_data.GetId();
  }

  //-----------------------------------------------------
  Future<void> insertOrder() async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://10.0.2.2/Flutter_project/DatabaseProcess/NewOrder.php'),
        body: {
          'TotalPrice': '0',
          'finished': '0',
          'Userid': User_id.toString(),
          "ordername": OrderNameTextfield.text.toString(),
        },
      );
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        fetchOrders();
        print("Order successfully inserted");
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  //-----------------------------------------

  void CreateNewOrder() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Ordercreationalert(
              CreateFunction: createNewOrder,
              popoffwindow: popoffWindow,
              OrderCreationName: OrderNameTextfield,
            ),
          );
        });
  }

  void createNewOrder() {
    insertOrder();
    popoffWindow();
  }

  void popoffWindow() {
    OrderNameTextfield.clear();
    Navigator.of(context).pop();
  }
  //-----------------------------------------

  void fetchOrders() async {
    Listorder.MakeEmpty();
    final response = await http.post(
        Uri.parse(
            'http://10.0.2.2/Flutter_project/DatabaseProcess/GetOrders.php'),
        body: {
          "UserId": User_id.toString(),
        });

    if (response.statusCode == 200) {
      print("fetch Starting...");
      setState(() {
        List<dynamic> jsonList = json.decode(response.body);
        List<OrderCreation> orders =
            jsonList.map((json) => OrderCreation.fromJson(json)).toList();
        OrderCreation headOrderData = new OrderCreation(
            OrderName: orders[0].OrderName,
            Cost: orders[0].Cost,
            OrderNumber: orders[0].OrderNumber,
            OrderCompleted: orders[0].OrderCompleted);
        DataNode headNode = new DataNode(order: headOrderData);
        Listorder.AddOrder(headNode);
        for (int x = 0; x < orders.length; x++) {
          DataNode nd = DataNode(order: orders[x]);
          print(orders[x].OrderNumber);
          Listorder.AddOrder(nd);
        }
      });
    } else {
      throw Exception('Failed to load orders');
    }
  }

//---------------------------------------------
  @override
  Widget build(BuildContext context) {
    print("Home Page is loaded with email: $email with ID : $User_id");
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text("My Orders"),
      )),
      backgroundColor: const Color.fromARGB(255, 42, 62, 78),
      floatingActionButton: FloatingActionButton(onPressed: CreateNewOrder),
      body: Center(
        child: GridView.builder(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 30,
          ),
          itemCount: Listorder.CountOrders(),
          itemBuilder: (context, index) {
            OrderCreation? order = Listorder.GetOrderAt(index);
            if (order != null) {
              return order;
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    );
  }
}
