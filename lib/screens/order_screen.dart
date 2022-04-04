import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app1/providers/orders.dart' show Orders;
import 'package:shop_app1/widgets/app_drawer.dart';
import 'package:shop_app1/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = '/order-screen';

  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (context, index) =>
            OrderItem(orderItem: orderData.orders[index]),
      ),
      drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child:
              BackdropFilter(filter: ImageFilter.blur(sigmaY: 15,sigmaX: 15), child: AppDrawer())),
    );
  }
}
