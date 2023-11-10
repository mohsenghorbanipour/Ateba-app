import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  const Modal({
    super.key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.only(
      topRight: Radius.circular(8),
      topLeft: Radius.circular(8),
    ),
    this.constraints,
  });
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsets margin;
  final BoxConstraints? constraints;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) => Container(
        padding: MediaQuery.of(context).viewInsets.add(EdgeInsets.zero),
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          borderRadius: borderRadius,
        ),
        constraints: constraints,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: child,
        ),
      );
}
