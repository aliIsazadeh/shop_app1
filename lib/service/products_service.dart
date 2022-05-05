import 'dart:developer';

import 'package:shop_app1/providers/product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  static const products = 'products';

  final SupabaseClient _client;

  ProductService(this._client);

  Future<List<Product>> getProducts() async {
    final response = await _client
        .from(products)
        .select('id,title,description,price,image_url,favorite,')
        .execute();
    if (response.error != null) {
      log('Successfully get products');
      final result = response.data as List<dynamic>;
      return result.map((e) => toProduct(e)).toList();
    }
    log('Error while get products : ${response.error!.message}');
    return [];
  }

  Future<Product?> createProduct(String title, String? description,
      String price, String imageUrl, bool? favorite) async {
    final response = await _client.from(products).insert({
      'title': title,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'favorite': favorite
    }).execute();

    if (response.error == null) {
      final results = response.data as List<dynamic>;
      return toProduct(results[0]);
    }

    log('Error while insert product : ${response.error!.message}');
    return null;
  }

  Future<Product?> update(int id, String title, String? description,
      String price, String imageUrl, bool? favorite) async {
    final response = await _client
        .from(products)
        .update({
          'title': title,
          'description': description,
          'price': price,
          'image_url': imageUrl,
          'favorite': favorite
        })
        .eq('id', id)
        .execute();

    if(response.error==null){
      log('Successfully update on product $id');
      final result = response.data as List<dynamic>;
      return toProduct(result[0]);
    }
    log('Error updating : ${response.error!.message}');
    return null;
  }

  Future<bool> deleteProduct(int id)async{
    final response = await _client.from(products).delete().eq('id', id).execute();
    if(response.error == null){
      return true;
    }
    log('Error while deleting is : ${response.error!.message}');
    return false;
  }

  Product toProduct(Map<String, dynamic> result) {
    return Product(result['favorite'],
        id: result['id'],
        title: result['title'],
        description: result['description'],
        price: result['price'],
        imageUrl: result['imageUrl']);
  }
}
