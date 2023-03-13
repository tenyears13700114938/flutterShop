import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/auth.dart';
import 'package:flutter_shop_app/screens/edit_products_screen.dart';
import 'package:flutter_shop_app/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

import '../provider/product.dart';
import '../provider/products.dart';

class UserProduct extends StatelessWidget {
  final Product product;

  const UserProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductsScreen.routeName,
                    arguments: product);
              },
              icon: const Icon(Icons.edit)),
          IconButton(
            onPressed: () {
              final uid = Provider.of<Auth>(context, listen: false).uid;
              Provider.of<Products>(context, listen: false)
                  .deleteProduct(product.id, uid)
                  .onError((error, stackTrace) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("delete product failed..",
                      style: TextStyle(color: Theme.of(context).errorColor)),
                  duration: const Duration(seconds: 2),
                ));
              });
            },
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          )
        ],
      ),
    );
  }
}
