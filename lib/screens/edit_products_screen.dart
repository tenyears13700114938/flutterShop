import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth.dart';
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
  var _isInit = false;
  var _isLoading = false;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      final argumentProduct =
          ModalRoute.of(context)?.settings.arguments as Product?;
      if (argumentProduct != null) {
        _product = argumentProduct;
        _imageUrlEditingController.text = _product.imageUrl;
      }
    }
    _isInit = true;
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _form,
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: "title"),
                    textInputAction: TextInputAction.next,
                    initialValue: _product.title,
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
                    initialValue: _product.price.toString(),
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
                    initialValue: _product.description,
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
                                child: Image.network(
                                    _imageUrlEditingController.text),
                              ),
                      ),
                      Expanded(
                          child: TextFormField(
                        decoration:
                            const InputDecoration(labelText: "image url"),
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
    setState(() {
      _isLoading = true;
    });
    String? uid = Provider.of<Auth>(context, listen: false).uid;
    if (_product.id.isEmpty) {
      Provider.of<Products>(context, listen: false)
          .addProduct(_product, uid)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
        showWarningDialog().then((value) {
          Navigator.of(context).pop();
        });
      });
    } else {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_product, uid)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }).onError((error, stackTrace) {
        setState(() {
          _isLoading = false;
        });
        showWarningDialog().then((value) {
          Navigator.of(context).pop();
        });
      });
    }
  }

  Future<dynamic> showWarningDialog() => showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("save record error"),
          content: const Text("when save product, there is a error.."),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text("OK"))
          ],
        );
      });
}
