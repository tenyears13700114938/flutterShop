import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _localProducts = [];

  static const baseUrl =
      "https://tenyears-flutter-shop-project-default-rtdb.asia-southeast1.firebasedatabase.app/";

  List<Product> get products => [..._localProducts];

  List<Product> get favoriteProducts =>
      _localProducts.where((element) => element.isFavorite).toList();

  Future<void> fetchAndSetProducts() async {
    final ref = FirebaseDatabase.instance.ref("products");
    ref.get().then((snapShot) {
      if (snapShot.exists) {
        _localProducts.clear();
        for (var entry in snapShot.children) {
          final key = entry.key!;
          final value = entry.value as Map<dynamic, dynamic>;
          _localProducts.add(Product(
              id: key,
              title: value['title'],
              description: value['description'],
              price: double.parse(value['price'].toString()),
              imageUrl: value['imageUrl'],
              isFavorite: value['isFavorite']));
        }
        notifyListeners();
      }
    });
  }

  Product findById(String id) {
    return _localProducts.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Product product) async {
    final ref = FirebaseDatabase.instance.ref("products");
    final newKey = ref.push().key;
    await ref.child("$newKey").set({
      'title': product.title,
      'description': product.description,
      'imageUrl': product.imageUrl,
      'price': product.price,
      'isFavorite': product.isFavorite,
    });
    //await Future.delayed(Duration(milliseconds: 3000));
    _localProducts.add(Product(
        id: newKey!,
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    final ref = FirebaseDatabase.instance.ref("products").child(product.id);
    await ref.update({
      'title': product.title,
      'description': product.description,
      'imageUrl': product.imageUrl,
      'price': product.price,
      'isFavorite': product.isFavorite,
    });
    //await Future.delayed(Duration(milliseconds: 3000));
    final index =
        _localProducts.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      _localProducts[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final ref = FirebaseDatabase.instance.ref("products").child(id);
    await ref.remove();
    _localProducts.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
