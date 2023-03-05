import 'package:flutter/material.dart';

import '../provider/product.dart';

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
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          )
        ],
      ),
    );
  }
}
