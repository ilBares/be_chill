import 'package:be_chill/src/presentation/common/vertical_widget.dart';
import 'package:be_chill/src/presentation/widgets/post_rating.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const RatingHandler(images: [
      AssetImage("assets/images/post_5.jpeg"),
      AssetImage("assets/images/post_1.jpeg"),
      AssetImage("assets/images/post_2.jpeg"),
      AssetImage("assets/images/post_3.jpeg"),
      AssetImage("assets/images/post_4.jpeg"),
    ]);
  }
}

class RatingHandler extends StatefulWidget {
  const RatingHandler({super.key, required this.images});

  final List<ImageProvider> images;

  @override
  State<RatingHandler> createState() => _RatingHandlerState();
}

class _RatingHandlerState extends State<RatingHandler> {
  final _controller = PageController();
  late List<PostRating> children;

  @override
  void initState() {
    children = widget.images
        .map((image) => PostRating(
              onLongPressEnd: onLongPressEnd,
              // onHorizontalDragStart: onHorizontalDragStart,
              image: image,
            ))
        .toList();
    super.initState();
  }

  void onLongPressEnd(_) {
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onHorizontalDragStart(_) {
    // Navigator.of(context)
    //     .push(CupertinoPageRoute(builder: (context) => const ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            children: children,
          ),
          const VerticalText(
            alignment: Alignment.centerRight,
            text: "PROFILE",
            color: Colors.white38,
          ),
          const VerticalText(
            alignment: Alignment.centerLeft,
            text: "PUBLISH",
            color: Colors.white38,
          ),
        ],
      ),
    );
  }
}
