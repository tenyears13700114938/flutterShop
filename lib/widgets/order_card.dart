import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/order_item.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final OrderItem item;

  const OrderCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(6),
      child: Column(children: [
        ListTile(
          title: Text("\$${item.amount}"),
          subtitle: Text(DateFormat("dd MM yyyy hh:mm").format(item.dateTime)),
          trailing: IconButton(
            icon: const Icon(Icons.expand_more),
            onPressed: () {},
          ),
        )
      ]),
    );
  }
}
