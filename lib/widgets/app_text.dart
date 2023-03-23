// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class AppText extends StatefulWidget {
  final String text;
  final Color textColor;

  const AppText({
    Key? key,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(color: widget.textColor),
    );
  }
}
