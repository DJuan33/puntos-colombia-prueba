import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) => LimitedBox(
        maxWidth: 240,
        child: SizedBox(
          height: 50,
          child: TextButton(
            onPressed: onPressed,
            child: child,
          ),
        ),
      );
}
