import 'package:flutter_application_1/Lists/ClientsList/DataNodeClient.dart';

class Clientnode {
  Datanodeclient Dataclientnode;
  Clientnode? next;

  Clientnode({required this.Dataclientnode}) {
    next = null;
  }
}
