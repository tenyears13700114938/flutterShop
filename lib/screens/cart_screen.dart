import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/cart_card.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total"),
                  Chip(
                      label: Text("\$${cart.itemsAmount}",
                          style:
                              Theme.of(context).primaryTextTheme.titleMedium)),
                  TextButton(
                    // style: ButtonStyle(
                    //     foregroundColor:
                    //         MaterialStateProperty.all<Color>(Colors.blue),
                    //     overlayColor:
                    //         MaterialStateProperty.resolveWith((states) {
                    //       if (states.contains(MaterialState.hovered)) {
                    //         return Colors.blue.withOpacity(0.04);
                    //       }
                    //       if (states.contains(MaterialState.focused) ||
                    //           states.contains(MaterialState.pressed)) {
                    //         return Colors.blue.withOpacity(0.12);
                    //       }
                    //       return null;
                    //     })),
                    child: const Text("Order Now"),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, index) => CartCard(
              item: cart.items.values.toList()[index],
              onChangeItemQuality: (item, qualityDelta) {
                cart.changeItemQuantity(item, qualityDelta);
              },
            ),
            itemCount: cart.itemsCount,
          ))
        ],
      ),
    );
  }
}
