import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/AppLifecycleService.dart';
import 'package:flutter_shop_app/provider/auth.dart';
import 'package:flutter_shop_app/provider/cart.dart';
import 'package:flutter_shop_app/provider/orders.dart';
import 'package:flutter_shop_app/provider/products.dart';
import 'package:flutter_shop_app/screens/auth_screen.dart';
import 'package:flutter_shop_app/screens/cart_screen.dart';
import 'package:flutter_shop_app/screens/edit_products_screen.dart';
import 'package:flutter_shop_app/screens/order_screen.dart';
import 'package:flutter_shop_app/screens/product_detail_screen.dart';
import 'package:flutter_shop_app/screens/products_overview_screen.dart';
import 'package:flutter_shop_app/screens/user_products_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("myDebug myApp build...");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider<Cart>(create: (_) => Cart()),
        ChangeNotifierProvider<Orders>(create: (_) => Orders()),
        ChangeNotifierProvider<Auth>(create: (_) => Auth()),
        ChangeNotifierProvider(create: (_) => AppLifecycleService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Consumer<Auth>(builder: (context, auth, _) {
          return auth.isLogin
              ? const ProductsOverviewScreen()
              : const AuthScreen();
        }),
        routes: {
          ProductsOverviewScreen.routeName: (ctx) {
            return const ProductsOverviewScreen();
          },
          ProductDetailScreen.routeName: (ctx) {
            return const ProductDetailScreen();
          },
          CartScreen.routeName: (ctx) {
            return const CartScreen();
          },
          OrderScreen.routeName: (ctx) {
            return const OrderScreen();
          },
          UserProductsScreen.routeName: (ctx) {
            return const UserProductsScreen();
          },
          EditProductsScreen.routeName: (ctx) {
            return const EditProductsScreen();
          },
          AuthScreen.routeName: (ctx) {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
