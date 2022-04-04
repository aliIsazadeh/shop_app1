import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app1/providers/cart.dart';

import '../providers/product.dart';
import '../screens/product_details_screen.dart';

class ProductsGridTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final iconColor = Theme
        .of(context)
        .colorScheme
        .secondary;
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailsScreen.routeName, arguments: product.id);
        },
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      footer: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: Theme
                .of(context)
                .primaryColor),
            color: Colors.black54),
        child: GridTileBar(
          title: AutoSizeText(
            product.title,
            style: const TextStyle(fontSize: 12),
          ),
          leading: Consumer<Product>(
            builder: (context, value, child) =>
                IconButton(
                  icon: Icon(
                      value.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: iconColor),
                  onPressed: () {
                    value.toggleFavorite();
                  },
                ),
          ),
          trailing: Consumer<Cart>(builder: (_, cart, child) =>
              IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                  color: iconColor,
                ),
                onPressed: () {
                  cart.addItem(
                      product.id, product.price.toString(), product.title);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Add item to cart!'),
                    action: SnackBarAction(label: 'UNDO', onPressed: () => cart.removeSingleItem(product.id)),));
                },
              ),
          ),
        ),
      ),
    );
  }
}
