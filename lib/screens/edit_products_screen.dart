import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product.dart';
import '../provider/products.dart';

class EditProductsScreen extends StatefulWidget {
  static const String routeName = "editProduct";

  const EditProductsScreen({Key? key}) : super(key: key);

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final TextEditingController _imageUrlEditingController =
      TextEditingController();
  final _imageUrlEditingFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _product =
      Product(id: "", title: "", description: "", imageUrl: "", price: 0);

  @override
  void initState() {
    super.initState();
    _imageUrlEditingFocusNode.addListener(() {
      if (!_imageUrlEditingFocusNode.hasFocus &&
          (_imageUrlEditingController.text.startsWith("http") ||
              _imageUrlEditingController.text.startsWith("https"))) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Products"),
        actions: [
          IconButton(
              onPressed: () {
                _saveForm();
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "title"),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please input title..";
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  _product = Product(
                      id: _product.id,
                      title: value,
                      description: _product.description,
                      price: _product.price,
                      imageUrl: _product.imageUrl);
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "price"),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null) {
                  return "please input price..";
                }
                if (double.tryParse(value) == null) {
                  return "please input valid number..";
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  _product = Product(
                      id: _product.id,
                      title: _product.title,
                      description: _product.description,
                      price: double.parse(value),
                      imageUrl: _product.imageUrl);
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "description"),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please input your description..";
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  _product = Product(
                      id: _product.id,
                      title: _product.title,
                      description: value,
                      price: _product.price,
                      imageUrl: _product.imageUrl);
                }
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(top: 8, right: 10),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: _imageUrlEditingController.text.isEmpty
                      ? const Text("enter image url")
                      : FittedBox(
                          fit: BoxFit.cover,
                          child: Image.network(_imageUrlEditingController.text),
                        ),
                ),
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(labelText: "image url"),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.url,
                  controller: _imageUrlEditingController,
                  focusNode: _imageUrlEditingFocusNode,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please input url..";
                    }
                    if (!value.startsWith("http") ||
                        !value.startsWith("https")) {
                      return "please input invalid url..";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    if (value != null) {
                      _product = Product(
                          id: _product.id,
                          title: _product.title,
                          description: _product.description,
                          price: _product.price,
                          imageUrl: value);
                    }
                  },
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _imageUrlEditingController.dispose();
    _imageUrlEditingFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (isValid == null || isValid == false) {
      return;
    }
    _form.currentState?.save();
    Provider.of<Products>(context, listen: false).addProduct(_product);
    Navigator.of(context).pop();
  }
}
