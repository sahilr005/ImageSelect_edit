import 'package:flutter/material.dart';

class SrcText extends StatefulWidget {
  final text;
  const SrcText({Key? key, this.text}) : super(key: key);

  @override
  State<SrcText> createState() => _SrcTextState();
}

class _SrcTextState extends State<SrcText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: Text(widget.text == "jatin" ? "true" : "false"),
    );
  }
}
