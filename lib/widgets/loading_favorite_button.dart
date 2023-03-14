import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth.dart';
import '../provider/product.dart';

class LoadingFavoriteButton extends StatefulWidget {
  final Product product;

  const LoadingFavoriteButton({Key? key, required this.product})
      : super(key: key);

  @override
  State<LoadingFavoriteButton> createState() => _LoadingIconBuutonState();
}

class _LoadingIconBuutonState extends State<LoadingFavoriteButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
            padding: const EdgeInsets.all(12),
            child: const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(),
            ),
          )
        : IconButton(
            icon: Icon(widget.product.isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              final userId = Provider.of<Auth>(context, listen: false).uid;
              widget.product.toggleFavorite(userId).then((value) {
                setState(() {
                  _isLoading = false;
                });
              });
            },
          );
  }
}
