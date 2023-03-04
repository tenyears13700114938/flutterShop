import 'package:flutter/cupertino.dart';

import '../models/cart_item.dart';
import '../models/order_item.dart';

class Orders with ChangeNotifier {
  List<OrderItem> _items = [];

  List<OrderItem> get items => _items;

  void addOrder(List<CartItem> products, double amount) {
    _items.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: amount,
            products: products,
            dateTime: DateTime.now()));
    notifyListeners();
  }

  void clear() {
    _items = [];
    notifyListeners();
  }
}
