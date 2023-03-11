import 'package:flutter/material.dart';

class LoadingTextButton extends StatefulWidget {
  final Widget child;
  Future<void> Function() onPressed;

  LoadingTextButton({Key? key, required this.child, required this.onPressed})
      : super(key: key);

  @override
  State<LoadingTextButton> createState() => _LoadingTextButtonState();
}

class _LoadingTextButtonState extends State<LoadingTextButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          await widget.onPressed();
          setState(() {
            _isLoading = false;
          });
        },
        child: _isLoading ? const CircularProgressIndicator() : widget.child);
  }
}
