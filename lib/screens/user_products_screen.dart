import 'package:flutter/material.dart';
import 'package:flutter_shop_app/screens/edit_products_screen.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:flutter_shop_app/widgets/user_product.dart';
import 'package:provider/provider.dart';

import '../provider/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = "user-products";

  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductsScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) => Column(children: [
          UserProduct(product: productsData.products[index]),
          const Divider(),
        ]),
        itemCount: productsData.products.length,
      ),
    );
  }
}
