import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app1/providers/products.dart';
import 'package:shop_app1/screens/product_adding_screen.dart';
import 'package:shop_app1/widgets/app_drawer.dart';
import 'package:shop_app1/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const String routeName = '/user-product-screen';

  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productsItems = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.of(context).pushReplacementNamed(ProductAddingScreen.routeName);
                Navigator.push(context, MaterialPageRoute(builder: (context) =>const  ProductAddingScreen()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: productsItems.items.length,
          itemBuilder: (context, index) => UserProductItem(
            id: productsItems.items[index].id,
            title: productsItems.items[index].title,
            imageUrl: productsItems.items[index].imageUrl,
          ),
        ),
      ),
      drawer: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AppDrawer())),
    );
  }
}
