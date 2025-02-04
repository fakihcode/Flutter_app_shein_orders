import 'package:flutter_application_1/Containers/Clientscreate.dart';
import 'package:flutter_application_1/Lists/ClientsList/DataNodeClient.dart';
import 'package:flutter_application_1/Lists/ClientsList/clienNode.dart';

class ClientList {
  Clientnode? head;
  ClientList() {
    head = null;
  }

  void AddHeadclient(Datanodeclient cd) {
    if (head == null) {
      Clientnode cn = new Clientnode(Dataclientnode: cd);
      head = cn;
    } else {
      Clientnode cn = new Clientnode(Dataclientnode: cd);
      cn.next = head;
      head = cn;
    }
  }

  bool IsEmpty() {
    return head == null;
  }

  int CountClients() {
    int length = 0;
    Clientnode? curr = this.head;

    while (curr != null) {
      length++;
      curr = curr.next;
    }
    return length;
  }

  void AddClient(Datanodeclient cl) {
    if (IsEmpty()) {
      AddHeadclient(cl);
    } else {
      Clientnode? curr;
      Clientnode oc = new Clientnode(Dataclientnode: cl);
      curr = this.head;
      while (curr?.next != null) {
        curr = curr?.next;
      }
      curr?.next = oc;
    }
  }

  void printClients() {
    Clientnode? curr = head;
    if (IsEmpty()) {
      print("list is empty ");
    } else {
      while (curr != null) {
        print(curr.Dataclientnode.client.clientname);
        curr = curr.next;
      }
    }
  }

  void MakeEmpty() {
    this.head = null;
  }

  ClientCreation? GetClientAt(int index) {
    int count = 0;
    Clientnode? curr = head;
    while (curr != null) {
      if (count == index) {
        return curr.Dataclientnode.client;
      }
      count++;
      curr = curr.next;
    }
    return null;
  }
}
