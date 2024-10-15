import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  // ignore: use_super_parameters
  const NeuBox({Key? key, this.child, this.width, this.height})
      : super(key: key);

  final Widget? child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      constraints: BoxConstraints(
        minHeight: height ?? 50,
        maxWidth: width ?? 50,
      ),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? const Color.fromARGB(206, 190, 141, 141)
            : const Color.fromARGB(178, 248, 201, 201), 
        borderRadius: BorderRadius.circular(12), 
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
