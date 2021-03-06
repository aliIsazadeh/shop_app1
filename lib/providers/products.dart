import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      false,
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      false,
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      false,
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      false,
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return items.firstWhere((element) => id == element.id);
  }

  List<Product> get favoriteItems {
    return items.where((element) => element.isFavorite).toList();
  }

  void addProducts(Product product) {
    final url = Uri.parse(
        "https://shope-app-project1-default-rtdb.firebaseio.com/products.json");
    http
        .post(
          url,
          body: json.encode(
            {
              'title': product.title,
              'price': product.price,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'isFavorite': product.isFavorite
            },
          ),
        )
        .then(
          (response) {
            _items.add(Product(product.isFavorite,
                id: json.decode(response.body)['name'],
                title: product.title,
                description: product.description,
                price: product.price,
                imageUrl: product.imageUrl));
            notifyListeners();
          },
        );


  }

  void updateProduct(String id, Product updateProduct) {
    if (id.isNotEmpty) {
      final int index = items.indexWhere((element) => id == element.id);
      items[index] = updateProduct;
      notifyListeners();
    }
  }

  void removeProduct(String id) {
    if (id.isNotEmpty) {
      print('its removing');
      int index = (_items.indexWhere((element) => element.id == id));

      _items.removeAt(index);
      notifyListeners();
      print(items.length);
    }
  }
}
