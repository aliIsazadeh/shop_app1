import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:shop_app1/screens/product_details_screen.dart';
import 'package:shop_app1/widgets/products_grid_tile.dart';

import '../providers/product.dart';

class ProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      child: ProductsGridTile(
      ),
    );
  }
}
