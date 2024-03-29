import 'package:be_chill/src/presentation/common/vertical_widget.dart';
import 'package:be_chill/data/dummy_user.dart';
import 'package:be_chill/src/presentation/views/friends_view.dart';
import 'package:be_chill/src/presentation/widgets/avatar_section.dart';
import 'package:be_chill/src/presentation/widgets/post_grid_section.dart';
import 'package:flutter/material.dart';

enum SelectedView {
  myself,
  friends,
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = PageController();

  void _showMyselfView() {
    setState(() => _controller.jumpToPage(0));
  }

  void _showFriendsView() {
    setState(() => _controller.jumpToPage(1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                ViewSelector(
                  onMyselfSelected: _showMyselfView,
                  onFriendsSelected: _showFriendsView,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: PageView(
                      controller: _controller,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        MyselfView(),
                        FriendsView(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const VerticalText(
            text: "FEED",
            color: Colors.black87,
            alignment: Alignment.centerLeft,
          ),
          const VerticalText(
            text: "RANKING",
            color: Colors.black87,
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }
}

///
/// MYSELF VIEW
///
class MyselfView extends StatelessWidget {
  const MyselfView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: AvatarSection(user: user),
        ),
        const SizedBox(height: 8.0),
        Expanded(
          flex: 8,
          child: PostGridSection.profile(posts),
        ),
      ],
    );
  }
}

///
/// FRIENDS VIEW
///
class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const FriendsScreen();
  }
}

///
/// VIEW SELECTOR
///
class ViewSelector extends StatefulWidget {
  const ViewSelector({
    super.key,
    required this.onMyselfSelected,
    required this.onFriendsSelected,
  });

  final VoidCallback onMyselfSelected;
  final VoidCallback onFriendsSelected;

  @override
  State<ViewSelector> createState() => _ViewSelectorState();
}

class _ViewSelectorState extends State<ViewSelector> {
  SelectedView selected = SelectedView.myself;

  void _changeSelection(SelectedView newView) {
    if (newView != selected) {
      setState(() {
        selected = newView;

        switch (newView) {
          case SelectedView.myself:
            widget.onMyselfSelected();
            break;
          case SelectedView.friends:
            widget.onFriendsSelected();
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 8.0),
        InkWell(
          splashColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(45.0),
          onTap: () => _changeSelection(SelectedView.myself),
          child: SelectorText(
            'MYSELF',
            bold: selected == SelectedView.myself,
          ),
        ),
        const SizedBox(width: 16.0),
        InkWell(
          onTap: () => _changeSelection(SelectedView.friends),
          borderRadius: BorderRadius.circular(45.0),
          child: SelectorText(
            'FRIENDS',
            bold: selected == SelectedView.friends,
          ),
        ),
      ],
    );
  }
}

class SelectorText extends StatelessWidget {
  const SelectorText(this.text, {super.key, this.bold = false});

  final String text;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: bold ? Colors.black87 : Colors.black54,
        fontSize: 10.0,
        fontFamily: "monospace",
        fontFamilyFallback: const <String>["Courier"],
        fontWeight: bold ? FontWeight.w800 : FontWeight.normal,
        height: 1.0,
      ),
    );
  }
}
