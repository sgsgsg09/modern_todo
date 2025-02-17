// lib/widgets/custom_card.dart
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry margin;
  final double elevation;
  final ShapeBorder shape;
  final EdgeInsetsGeometry? padding;

  const CustomCard({
    Key? key,
    required this.child,
    this.color,
    this.margin = const EdgeInsets.symmetric(vertical: 8),
    this.elevation = 2,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: margin,
      elevation: elevation,
      shape: shape,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}
