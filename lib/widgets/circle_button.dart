// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final Function() onPressed;
  final Color color;
  final Color? backgroundColor;

  CircleButton({
    Key? key,
    required this.icon,
    this.iconSize = 24,
    required this.onPressed,
    this.color = Colors.black,
    Color? backgroundColor,
  })  : backgroundColor = backgroundColor ?? Colors.grey[200],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: const BoxConstraints(minWidth: 0),
      onPressed: onPressed,
      elevation: 1.0,
      fillColor: backgroundColor,
      padding: const EdgeInsets.all(8),
      shape: const CircleBorder(),
      child: Icon(
        icon,
        size: iconSize,
        color: color,
      ),
    );
  }
}
