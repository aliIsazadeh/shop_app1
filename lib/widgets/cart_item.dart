import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app1/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String price;
  final String title;
  final String quantity;

  CartItem(
      {required this.id,
      required this.productId,
      required this.price,
      required this.title,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context, listen: false);
    var removeDirection = DismissDirection.endToStart;
    return Dismissible(
      key: ValueKey(id),
      direction: removeDirection,
      confirmDismiss: (removeDirection) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: const Text('Are you sure to remove this order ?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  ),
                ],
              );
            });
      },
      background: Container(
        color: Theme.of(context).colorScheme.errorContainer,
        child: Icon(
          Icons.delete,
          color: Theme.of(context).backgroundColor,
        ),
      ),
      onDismissed: (_) {
        cart.removeItem(productId);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  '\$$price',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700),
                ),
              ),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            trailing: Text('x $quantity'),
            subtitle: Text(
                'Total: \$${double.parse(price) * double.parse(quantity)}'),
            title: Text(
              title,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
