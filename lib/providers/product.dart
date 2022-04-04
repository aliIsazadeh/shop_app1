import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
   final String id;
   String title;

   String description;
   double price;
   String imageUrl;
  bool isFavorite = false;

  Product(this.isFavorite,
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl});

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
