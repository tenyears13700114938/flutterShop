import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/products.dart';
import 'package:flutter_shop_app/screens/cart_screen.dart';
import 'package:flutter_shop_app/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';
import '../widgets/products_grid.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  static String routeName = "/productsOverViewScreen";
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavoriteOnly = false;
  var _initialize = false;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (!_initialize) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context, listen: false)
          .fetchAndSetProducts()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _initialize = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyShop"),
        actions: [
          PopupMenuButton(
              onSelected: (FilterOptions selectedOption) {
                setState(() {
                  if (selectedOption == FilterOptions.all) {
                    _showFavoriteOnly = false;
                  } else {
                    _showFavoriteOnly = true;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: FilterOptions.favorites,
                      child: Text("only Favorites"),
                    ),
                    const PopupMenuItem(
                      value: FilterOptions.all,
                      child: Text("show All"),
                    )
                  ]),
          Container(
              alignment: Alignment.center,
              child: Consumer<Cart>(
                builder: (ctx, cart, _) {
                  return Badge(
                    label: Text(cart.itemsCount.toString()),
                    child: GestureDetector(
                      child: const Icon(Icons.shopping_cart),
                      onTap: () {
                        Navigator.of(context).pushNamed(CartScreen.routeName);
                      },
                    ),
                  );
                },
              ))
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(showOnlyFavorite: _showFavoriteOnly),
    );
  }
}
