import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final List<Product> _localProducts = [];

  static const baseUrl =
      "https://tenyears-flutter-shop-project-default-rtdb.asia-southeast1.firebasedatabase.app/";

  List<Product> get products => [..._localProducts];

  List<Product> get favoriteProducts =>
      _localProducts.where((element) => element.isFavorite).toList();

  Products() {
    http.get(Uri.parse("${baseUrl}products.json")).then((value) {
      final Map<String, dynamic> productMap = jsonDecode(value.body);
      for (var entry in productMap.entries) {
        _localProducts.add(Product(
            id: entry.key,
            title: entry.value['title'],
            description: entry.value['description'],
            price: entry.value['price'],
            imageUrl: entry.value['imageUrl'],
            isFavorite: entry.value['isFavorite']));
      }
      notifyListeners();
    });
  }

  Product findById(String id) {
    return _localProducts.firstWhere((element) => element.id == id);
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(Uri.parse("${baseUrl}products.json"),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          }));
      //await Future.delayed(Duration(milliseconds: 3000));
      final body = json.decode(response.body);
      _localProducts.add(Product(
          id: body['id'].toString(),
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl));
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    try {
      await http.patch(Uri.parse("$baseUrl${product.id}.json"),
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          }));
      //await Future.delayed(Duration(milliseconds: 3000));
      final index =
          _localProducts.indexWhere((element) => element.id == product.id);
      if (index != -1) {
        _localProducts[index] = product;
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }

  void deleteProduct(String id) {
    _localProducts.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
