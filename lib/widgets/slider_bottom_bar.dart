// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SliderBottomBar extends StatelessWidget {
  const SliderBottomBar({
    Key? key,
    required this.child,
    required this.height,
    required this.isVisible,
  }) : super(key: key);

  final Widget child;
  final double height;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isVisible ? height : 0,
      child: Wrap(
        children: [child],
      ),
    );
  }
}
