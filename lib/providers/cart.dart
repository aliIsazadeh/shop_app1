import 'dart:ui';

import 'package:flutter/cupertino.dart';

class CartItem {
  final String id;

  final String title;
  final int quantity;
  final String price;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price});
}

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addItem(String id, String price, String title) {
      _items.update(
        id,
        (existingCartItem) => CartItem(
            id: id,
            title: title,
            quantity: existingCartItem.quantity + 1,
            price: price),
        ifAbsent: () => _items.putIfAbsent(
          id,
          () => CartItem(id: id, title: title, quantity: 1, price: price),
        ),
      );
      notifyListeners();


    // else {
    //   _items.putIfAbsent(
    //       id, () => CartItem(id: id, title: title, quantity: 1, price: price));
    // }
  }

  double get totalAmount{
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += double.parse(cartItem.price)*cartItem.quantity;
    });
    return total;
  }

  int get cartItemsCount {
    return _items.length;
  }

  void removeItem (String id){
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String productId){
    if(!_items.containsKey(productId)){
      return;
    }if (_items[productId]!.quantity>1){
      _items.update(productId, (existingItem) => CartItem(id: existingItem.id, title: existingItem.title, quantity: existingItem.quantity-1, price: existingItem.price));
    }else{
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
}
}
