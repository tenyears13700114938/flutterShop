import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() async {
    final ref = FirebaseDatabase.instance.ref("products").child(id);
    await ref.update({"isFavorite": !isFavorite});
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
