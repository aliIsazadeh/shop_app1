import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app1/providers/product.dart';
import 'package:shop_app1/providers/products.dart';
import 'package:shop_app1/widgets/product_widget.dart';

class ProductsGridView extends StatelessWidget{
  final isFav;


  ProductsGridView(this.isFav);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =isFav? productsData.favoriteItems : productsData.items;

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
      value:  products[index],
        child: Container(
          padding: const EdgeInsets.all(10),
          child: ProductWidget(),
        ),
      ),
      itemCount: products.length,
    );
  }

}