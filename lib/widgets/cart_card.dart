import 'package:flutter/material.dart';
import 'package:flutter_shop_app/models/cart_item.dart';

class CartCard extends StatelessWidget {
  final CartItem item;
  final void Function(CartItem, int quantityDelta) onChangeItemQuality;

  const CartCard(
      {Key? key, required this.item, required this.onChangeItemQuality})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      background: Container(
        color: Theme.of(context).cardColor,
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text(
                      "Do you want to remove the item from the cart?"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: const Text("No")),
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: const Text("Yes"))
                  ],
                ));
      },
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        onChangeItemQuality(item, -item.quantity);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text("${item.price}")),
            ),
            title: Text(item.title),
            subtitle: Text("Total: ${item.price * item.quantity} "),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () => onChangeItemQuality(item, -1),
                    icon: const Icon(Icons.remove)),
                Text("${item.quantity} x"),
                IconButton(
                  onPressed: () => onChangeItemQuality(item, 1),
                  icon: const Icon(Icons.add),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
