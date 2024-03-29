import 'package:flutter/material.dart';

class VerticalText extends StatelessWidget {
  const VerticalText({
    super.key,
    required this.text,
    required this.color,
    required this.alignment,
  });

  final Alignment alignment;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Wrap(
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        children: text
            .split("")
            .map(
              (string) => Text(
                string,
                style: TextStyle(
                  color: color,
                  fontSize: 12.0,
                  fontFamily: "monospace",
                  fontFamilyFallback: const <String>["Courier"],
                  height: 1.0,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
