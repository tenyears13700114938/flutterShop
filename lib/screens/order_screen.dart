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
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return OrderCard(item: orderData.items[index]);
        },
        itemCount: orderData.items.length,
      ),
    );
  }
}
