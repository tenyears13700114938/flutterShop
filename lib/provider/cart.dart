import 'package:flutter/cupertino.dart';

import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount => _items.length;

  double get itemsAmount {
    var amount = 0.0;
    _items.forEach((key, value) {
      amount += value.quantity * value.price;
    });
    return amount;
  }

  void addItem(CartItem item, {int quantityDelta = 1}) {
    if (_items.containsKey(item.id)) {
      final existingItem = _items[item.id] as CartItem;
      _items[item.id] = CartItem(
          id: existingItem.id,
          title: existingItem.title,
          quantity: existingItem.quantity + quantityDelta,
          price: existingItem.price);
    } else {
      _items.putIfAbsent(
          item.id,
          () => CartItem(
              id: item.id,
              title: item.title,
              quantity: quantityDelta,
              price: item.price));
    }

    notifyListeners();
  }

  bool hasItem(String productId) => _items.containsKey(productId);

  void toggleItem(CartItem item) {
    if (hasItem(item.id)) {
      final existingItem = _items[item.id] as CartItem;
      if (existingItem.quantity == 1) {
        _items.remove(item.id);
      } else {
        _items[item.id] = CartItem(
            id: existingItem.id,
            title: existingItem.title,
            quantity: existingItem.quantity - 1,
            price: existingItem.price);
      }
      notifyListeners();
    } else {
      addItem(item);
    }
  }

  void changeItemQuantity(CartItem item, int quantityDelta) {
    if (_items.containsKey(item.id)) {
      final exitingItemQuantity = item.quantity;
      if (exitingItemQuantity + quantityDelta > 0) {
        addItem(item, quantityDelta: quantityDelta);
      } else {
        _items.remove(item.id);
      }
      notifyListeners();
    }
  }
}
