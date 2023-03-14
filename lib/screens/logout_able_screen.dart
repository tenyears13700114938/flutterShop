import 'package:flutter/material.dart';
import 'package:flutter_shop_app/provider/auth.dart';
import 'package:flutter_shop_app/screens/auth_screen.dart';
import 'package:provider/provider.dart';

class LogoutAbleScreen extends StatelessWidget {
  final Widget child;

  const LogoutAbleScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, auth, _) {
        return auth.isLogin ? child : const AuthScreen();
      },
    );
  }
}
