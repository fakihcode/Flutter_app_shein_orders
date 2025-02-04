import 'package:flutter_application_1/Containers/Order.dart';
import 'DataNode.dart';
import 'OrderNode.dart';

class Orderlist {
  OrderNode? head;

  Orderlist() {
    this.head = null;
  }

  void AddHeadOrder(DataNode od) {
    if (head == null) {
      OrderNode On = new OrderNode(orderdata: od);
      head = On;
    } else {
      OrderNode On = new OrderNode(orderdata: od);
      On.next = head;
      head = On;
    }
  }

  bool IsEmpty() {
    return head == null;
  }

  int CountOrders() {
    int length = 1;
    OrderNode? curr = this.head;

    while (curr != null) {
      length++;
      curr = curr.next;
    }
    return length;
  }

  void AddOrder(DataNode od) {
    if (IsEmpty()) {
      AddHeadOrder(od);
    } else {
      OrderNode? curr;
      OrderNode on = new OrderNode(orderdata: od);
      curr = this.head;
      while (curr?.next != null) {
        curr = curr?.next;
      }
      curr?.next = on;
    }
  }

  void MakeEmpty() {
    this.head = null;
  }

  OrderCreation? GetOrderAt(int index) {
    int count = 0;
    OrderNode? curr = head;
    while (curr != null) {
      if (count == index) {
        return curr.next?.orderdata.order;
      }
      count++;
      curr = curr.next;
    }
    return null;
  }
}
