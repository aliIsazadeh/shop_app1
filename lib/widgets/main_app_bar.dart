import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../screens/products_overview_screen.dart';
import 'badge.dart';

class MainAppBar extends StatefulWidget with PreferredSizeWidget{
  @override
  State<StatefulWidget> createState() => _MainAppBar();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();

}

class _MainAppBar extends State<MainAppBar> {
  bool isFav = false;
  @override
  PreferredSizeWidget build(BuildContext context) {
    // TODO: implement build
    return  AppBar(
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

}