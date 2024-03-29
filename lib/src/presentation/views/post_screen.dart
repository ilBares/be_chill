import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Hero(
        tag: 'post${child.key}',
        child: child,
      ),
    );
  }
}
