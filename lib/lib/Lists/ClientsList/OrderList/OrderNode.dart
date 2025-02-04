import 'DataNode.dart';

class OrderNode {
  late DataNode orderdata;
  OrderNode? next;

  OrderNode({required this.orderdata}) {
    next = null;
  }
}
