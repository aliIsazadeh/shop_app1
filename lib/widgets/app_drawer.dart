import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app1/screens/order_screen.dart';
import 'package:shop_app1/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appBar() {
      return AppBar();
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).colorScheme.shadow,
              width: 2)
      ),
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: appBar().preferredSize.height,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Theme.of(context).backgroundColor,
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.shop,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  'Shop',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                onTap: () => Navigator.of(context).pushReplacementNamed('/'),
              ),
            ),
            const Divider(),
            Container(
              color: Theme.of(context).backgroundColor,
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.add_card,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  'Orders',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(OrderScreen.routeName),
              ),
            ),
            const Divider(),
            Container(
              color: Theme.of(context).backgroundColor,
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  'User Product',
                  style:
                  TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(UserProductScreen.routeName),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
