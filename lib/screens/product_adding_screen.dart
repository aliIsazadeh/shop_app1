import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app1/providers/product.dart';

import '../providers/products.dart';

class ProductAddingScreen extends StatefulWidget {
  static const String routeName = '/product-adding-screen';

  const ProductAddingScreen({Key? key}) : super(key: key);



  @override
  State<StatefulWidget> createState() => _ProductAddingScreen();
}

class _ProductAddingScreen extends State<StatefulWidget> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(false,
      id: "", title: "", description: "", price: 0, imageUrl: "");

  var _initProduct = {
      "id": "", "title": "", "description": "", "price": "", "imageUrl": "","isFavorite" : false};


  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  var _isInit = true;

  @override
  void didChangeDependencies() {

    if(_isInit){

      if(ModalRoute.of(context)?.settings.arguments != null) {
        final id = ModalRoute.of(context)?.settings.arguments as String;
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findById(id);
        _initProduct = {
          'id': id,
          'title': _editedProduct.title,
          "description": _editedProduct.description,
          "price": _editedProduct.price,
          "imageUrl": _editedProduct.imageUrl,
          'isFavorite':_editedProduct.isFavorite
        };
      }
      _imageUrlController.text = _initProduct['imageUrl'] as String;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (_imageUrlController.text.isEmpty ||
        (!_imageUrlController.text.startsWith("http") ||
                !_imageUrlController.text.startsWith('https')) ) {
      return;
    }

    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    if (!_form.currentState!.validate()) {
      return;
    }
    _form.currentState?.save();
    if(_editedProduct.id.isEmpty){
      Provider.of<Products>(context, listen: false).addProducts(_editedProduct);
    }else {
      print('update is working');
      Provider.of<Products>(context,listen: false).updateProduct(_editedProduct.id, _editedProduct);
    }
    Navigator.of(context,rootNavigator: true).pop(context);
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding New Product'),
        actions: [
          IconButton(onPressed: () => _saveForm(), icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initProduct['title'] as String,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      _editedProduct.isFavorite,
                      id: _editedProduct.id,
                      title: value as String,
                      description: _editedProduct.description,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "it can't be null";
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initProduct['price'].toString(),
                decoration: const InputDecoration(
                  label: Text('Price'),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (value) {
                  _editedProduct = Product(
                      _editedProduct.isFavorite,
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: _editedProduct.description,
                      price: double.parse(value!),
                      imageUrl: _editedProduct.imageUrl);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "it can't be null";
                  }
                  if (double.parse(value) < 0) {
                    return 'price can\'t be less then 0';
                  }
                  if (double.parse(value) == 0) {
                    return 'price can\'t be 0  ';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initProduct['description'] as String,
                decoration: const InputDecoration(
                  label: Text('Description'),
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _editedProduct = Product(
                      _editedProduct.isFavorite,
                      id: _editedProduct.id,
                      title: _editedProduct.title,
                      description: value as String,
                      price: _editedProduct.price,
                      imageUrl: _editedProduct.imageUrl);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return "it can't be null";
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Center(
                            child: Text('Enter Url'),
                          )
                        : FittedBox(
                            fit: BoxFit.fill,
                            child: Image.network(_imageUrlController.text)),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Enter URL'),
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onEditingComplete: () {},
                        onFieldSubmitted: (_) => _saveForm(),
                        onSaved: (value) {
                          _editedProduct = Product(
                              _editedProduct.isFavorite,
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: value as String);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "it can't be null";
                          }
                          if ((!value.startsWith("http") ||
                                  !value.startsWith('https'))) {
                            return 'URL is not valid';
                          }
                          return null;
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
