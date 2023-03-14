import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../models/cart_item.dart';
import '../models/order_item.dart';

class Orders with ChangeNotifier {
  final List<OrderItem> _items = [];

  List<OrderItem> get items => _items;

  Future<void> fetchOrders(String? uid) async {
    if (uid == null) {
      return;
    }
    final orders = FirebaseDatabase.instance.ref().child("orders").child(uid);
    final List<OrderItem> orderItems = [];
    orders.get().then((value) {
      if (value.exists) {
        for (var entry in value.children) {
          final key = entry.key!;
          final value = entry.value as Map<dynamic, dynamic>;

          final List<CartItem> products = [];
          final productsMap = value["products"] as Map<dynamic, dynamic>;
          for (var productEntry in productsMap.entries) {
            final productKey = productEntry.key!;
            final productValue = productEntry.value as Map<dynamic, dynamic>;
            products.add(CartItem(
                id: productKey,
                title: productValue["title"],
                quantity: productValue["quantity"],
                price: productValue["price"].toDouble()));
          }

          orderItems.add(OrderItem(
              id: key,
              amount: value["amount"].toDouble(),
              products: products,
              dateTime: DateTime.parse(value["dateTime"])));
        }
      }
      _items.clear();
      _items.addAll(orderItems);
      notifyListeners();
    });
  }

  Future<void> addOrder(
      List<CartItem> products, double amount, String? uid) async {
    if (uid == null) {
      return;
    }
    final orders = FirebaseDatabase.instance.ref().child("orders").child(uid);
    final addOrderKey = orders.push().key!;
    final timeStamp = DateTime.now();

    await orders.child(addOrderKey).set({
      "amount": amount,
      "dateTime": timeStamp.toIso8601String(),
    });
    final productsRef = orders.child(addOrderKey).child("products");
    for (var element in products) {
      await productsRef.child(element.id).set({
        "price": element.price,
        "title": element.title,
        "quantity": element.quantity
      });
    }

    _items.insert(
        0,
        OrderItem(
            id: addOrderKey,
            amount: amount,
            products: products,
            dateTime: timeStamp));
    notifyListeners();
  }
}
