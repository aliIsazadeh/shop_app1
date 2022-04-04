import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:shop_app1/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {

   final List<OrderItem> _orderItems = [];

  List<OrderItem> get orders{
    return [..._orderItems];
  }

  void addOrder(List<CartItem> cartItems,double total ){
    _orderItems.add(OrderItem(id: DateTime.now().toString(), amount: total, products: cartItems, dateTime: DateTime.now()));
  }


}
