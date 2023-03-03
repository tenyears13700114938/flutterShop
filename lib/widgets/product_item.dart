import 'package:flutter/material.dart';
import 'package:flutter_shop_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';
import '../provider/cart.dart';
import '../provider/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = Provider.of<Product>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: Consumer<Product>(builder: (ctx, product, _) {
            return IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavorite();
              },
            );
          }),
          title: Text(product.title),
          backgroundColor: Colors.black45,
          trailing: Consumer<Cart>(
            builder: (ctx, cart, _) {
              return IconButton(
                icon: Icon(cart.hasItem(product.id)
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined),
                onPressed: () {
                  cart.toggleItem(CartItem(
                      id: product.id,
                      title: product.title,
                      quantity: 1,
                      price: product.price));
                },
              );
            },
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
