// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SliderAppAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SliderAppAppBar({
    Key? key,
    required this.child,
    required this.visible,
  }) : super(key: key);

  final PreferredSizeWidget child;
  final bool visible;

  @override
  State<SliderAppAppBar> createState() => _SliderAppAppBarState();

  @override
  Size get preferredSize => child.preferredSize;
}

class _SliderAppAppBarState extends State<SliderAppAppBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.visible ? _controller.reverse() : _controller.forward();
    return SlideTransition(
        position:
            Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1)).animate(
          CurvedAnimation(parent: _controller, curve: Curves.linear),
        ),
        child: widget.child);
    // return AnimatedContainer(
    //   duration: const Duration(milliseconds: 200),
    //   height: widget.visible
    //       ? widget.child.preferredSize.height +
    //           MediaQuery.of(context).viewPadding.top
    //       : 0,
    //   child: widget.child,
    // );
  }
}
