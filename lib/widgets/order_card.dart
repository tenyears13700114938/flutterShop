import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/order_item.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatefulWidget {
  final OrderItem item;

  const OrderCard({Key? key, required this.item}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  var isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height:
          isExpanded ? min(widget.item.products.length * 20 + 140, 400) : 100,
      curve: Curves.fastOutSlowIn,
      child: Card(
        margin: const EdgeInsets.all(6),
        child: Column(children: [
          ListTile(
            title: Text("\$${widget.item.amount}"),
            subtitle: Text(
                DateFormat("dd/MM/yyyy hh:mm").format(widget.item.dateTime)),
            trailing: IconButton(
              icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: isExpanded
                ? min(widget.item.products.length * 20 + 40, 300)
                : 0,
            curve: Curves.fastOutSlowIn,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                final product = widget.item.products[index];
                return Row(
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${product.quantity}x  \$${product.price}",
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    )
                  ],
                );
              },
              itemCount: widget.item.products.length,
            ),
          )
        ]),
      ),
    );
  }
}
