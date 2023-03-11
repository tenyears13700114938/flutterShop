import 'package:flutter/material.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:flutter_shop_app/widgets/order_card.dart';
import 'package:provider/provider.dart';

import '../provider/orders.dart';

class OrderScreen extends StatelessWidget {
  static String routeName = "order";

  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Orders"),
        ),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (ctx, asyncSnapShot) {
            if (asyncSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (asyncSnapShot.hasError) {
              return const Center(child: Text("An error occurred!"));
            }
            return Consumer<Orders>(builder: (ctx, orders, _) {
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  return OrderCard(item: orders.items[index]);
                },
                itemCount: orders.items.length,
              );
            });
          },
        ));
  }
}
