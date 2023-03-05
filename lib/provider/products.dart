import 'package:flutter/cupertino.dart';
import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _localProducts = [
    Product(
        id: "p1",
        title: "beach sunset",
        description: "very beautiful...",
        price: 80,
        imageUrl: "https://picsum.photos/250?image=9"),
    Product(
        id: "p2",
        title: "monkey",
        description: "i like monkey...",
        price: 90,
        imageUrl: "https://picsum.photos/250?image=8"),
    Product(
        id: "p3",
        title: "bird",
        description: "fly in the sky...",
        price: 99,
        imageUrl: "https://picsum.photos/250?image=7"),
    Product(
        id: "p4",
        title: "gorilla",
        description: "it is black...",
        price: 100,
        imageUrl: "https://picsum.photos/250?image=6"),
    Product(
        id: "p5",
        title: "beach sunset",
        description: "very beautiful...",
        price: 80,
        imageUrl: "https://picsum.photos/250?image=9"),
    Product(
        id: "p6",
        title: "monkey",
        description: "i like monkey...",
        price: 90,
        imageUrl: "https://picsum.photos/250?image=8"),
    Product(
        id: "p7",
        title: "bird",
        description: "fly in the sky...",
        price: 99,
        imageUrl: "https://picsum.photos/250?image=7"),
    Product(
        id: "p4",
        title: "gorilla",
        description: "it is black...",
        price: 100,
        imageUrl: "https://picsum.photos/250?image=6"),
    Product(
        id: "p8",
        title: "beach sunset",
        description: "very beautiful...",
        price: 80,
        imageUrl: "https://picsum.photos/250?image=9"),
    Product(
        id: "p9",
        title: "monkey",
        description: "i like monkey...",
        price: 90,
        imageUrl: "https://picsum.photos/250?image=8"),
    Product(
        id: "p10",
        title: "bird",
        description: "fly in the sky...",
        price: 99,
        imageUrl: "https://picsum.photos/250?image=7"),
    Product(
        id: "p11",
        title: "gorilla",
        description: "it is black...",
        price: 100,
        imageUrl: "https://picsum.photos/250?image=6")
  ];

  List<Product> get products => [..._localProducts];

  List<Product> get favoriteProducts =>
      _localProducts.where((element) => element.isFavorite).toList();

  Products() {
    notifyListeners();
  }

  Product findById(String id) {
    return _localProducts.firstWhere((element) => element.id == id);
  }

  void addProduct(Product product) {
    _localProducts.add(Product(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl));
    notifyListeners();
  }
}
