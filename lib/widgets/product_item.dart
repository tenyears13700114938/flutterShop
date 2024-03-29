import 'package:flutter/material.dart';
import 'package:flutter_shop_app/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/cart_item.dart';
import '../provider/cart.dart';
import '../provider/product.dart';
import 'loading_favorite_button.dart';

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
            return LoadingFavoriteButton(product: product);
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
                  final snackMessage = !cart.hasItem(product.id)
                      ? "add item to cart!"
                      : "remove item from cart!";
                  cart.toggleItem(CartItem(
                      id: product.id,
                      title: product.title,
                      quantity: 1,
                      price: product.price));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(snackMessage),
                    duration: const Duration(seconds: 2),
                  ));
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
          child: Hero(
            tag: product.id,
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
