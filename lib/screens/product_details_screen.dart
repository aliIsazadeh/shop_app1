import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app1/providers/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = '/product-details-screen';

  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              loadedProduct.imageUrl,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'price : \$${loadedProduct.price}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      loadedProduct.description,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
