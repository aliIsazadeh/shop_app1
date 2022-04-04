import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app1/screens/cart_screen.dart';
import 'package:shop_app1/widgets/app_drawer.dart';
import 'package:shop_app1/widgets/badge.dart';
import 'package:shop_app1/widgets/products_grid_view.dart';

import '../providers/cart.dart';

enum IsFavorite { favorite, notFavorite }

class ProductsOverViewScreen extends StatefulWidget {
  const ProductsOverViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  var isFav = false;

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar(
        title: const Text('Products'),
        actions: [
          PopupMenuButton(
              onSelected: (selectedValue) {
                setState(() {
                  if (selectedValue == IsFavorite.favorite) {
                    isFav = true;
                  } else {
                    isFav = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      child: Text('only favorites'),
                      value: IsFavorite.favorite,
                    ),
                    const PopupMenuItem(
                      child: Text('show all'),
                      value: IsFavorite.notFavorite,
                    ),
                  ]),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch as Widget,
              value: cart.cartItemsCount.toString(),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: appBar(),
      body: ProductsGridView(isFav),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
          child: AppDrawer(),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
