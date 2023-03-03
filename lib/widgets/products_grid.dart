import 'package:flutter/cupertino.dart';
import 'package:flutter_shop_app/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../provider/product.dart';
import '../provider/products.dart';

class ProductsGrid extends StatelessWidget {
  final bool showOnlyFavorite;

  const ProductsGrid({super.key, required this.showOnlyFavorite});

  @override
  Widget build(BuildContext context) {
    final products = !showOnlyFavorite
        ? context.watch<Products>().products
        : context.watch<Products>().favoriteProducts;

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 3 / 2,
        ),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) =>
            ChangeNotifierProvider.value(
              value: products[index],
              child: const ProductItem(),
            ));
  }
}
