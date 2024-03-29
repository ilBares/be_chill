import 'package:be_chill/src/presentation/views/feed_screen.dart';
import 'package:be_chill/src/presentation/views/profile_screen.dart';
import 'package:be_chill/src/presentation/views/publish_screen.dart';
import 'package:be_chill/src/presentation/views/ranking_screen.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _controller = PageController(initialPage: 1);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      children: [
        PublishScreen(
          onPickerClosed: () => _controller.animateToPage(
            _controller.initialPage,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          ),
        ),
        const FeedScreen(),
        const ProfileScreen(),
        const RankingScreen(),
      ],
    );
  }
}
