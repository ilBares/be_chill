import 'package:be_chill/src/presentation/shared/bechill_painter.dart';
import 'package:be_chill/src/presentation/views/post_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PostTile extends StatelessWidget {
  const PostTile.large({
    super.key,
    required this.rating,
    required this.child,
  })  : _mainAxisCellCount = 4,
        _crossAxisCellCount = 2;

  const PostTile.medium({
    super.key,
    required this.child,
    required this.rating,
  })  : _mainAxisCellCount = 2,
        _crossAxisCellCount = 2;

  const PostTile.small({
    super.key,
    required this.child,
    required this.rating,
  })  : _mainAxisCellCount = 2,
        _crossAxisCellCount = 1;

  const PostTile.tiny({
    super.key,
    required this.child,
    required this.rating,
  })  : _mainAxisCellCount = 1,
        _crossAxisCellCount = 1;

  const PostTile.add({
    super.key,
  })  : _mainAxisCellCount = 1,
        _crossAxisCellCount = 1,
        rating = 0.0,
        child = const AddPostTile();

  final int _mainAxisCellCount;
  final int _crossAxisCellCount;
  final double rating;
  final Widget child;
  final Color? backgroundColor = Colors.black38;

  @override
  Widget build(BuildContext context) {
    return StaggeredGridTile.count(
      mainAxisCellCount: _mainAxisCellCount,
      crossAxisCellCount: _crossAxisCellCount,
      child: GestureDetector(
        onTap: () => {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (BuildContext context) => PostScreen(
                child: child,
              ),
            ),
          )
        },
        child: Hero(
          tag: 'post${child.key}',
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return GestureDetector(
      child: Container(
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          color: rating > 0.0
              ? backgroundColor
              : Colors.blueGrey.shade100.withOpacity(0.5),
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: FittedBox(
                alignment: Alignment.bottomCenter,
                fit: BoxFit.cover,
                child: Opacity(
                  opacity: 0.8,
                  child: child,
                ),
              ),
            ),
            if (rating > 0.0) BeChillRating(rating: rating),
          ],
        ),
      ),
    );
  }
}

class AddPostTile extends StatefulWidget {
  const AddPostTile({
    super.key,
  });

  @override
  State<AddPostTile> createState() => _AddPostTileState();
}

class _AddPostTileState extends State<AddPostTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 15.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        shadows: [
          BoxShadow(
            color: Colors.blueGrey,
            blurRadius: _animation.value,
            spreadRadius: _animation.value,
          ),
        ],
        Icons.add,
        color: Colors.black.withAlpha(200 - (5 * _animation.value).toInt()),
      ),
    );
  }
}

class BeChillRating extends StatefulWidget {
  const BeChillRating({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  State<BeChillRating> createState() => _BeChillRatingState();
}

class _BeChillRatingState extends State<BeChillRating>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 10.0, end: 40.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            blurRadius: _animation.value,
            // spreadRadius: _animation.value,
          ),
        ],
      ),
      child: CustomPaint(
        size: const Size.fromRadius(25),
        painter: BeChillPainter(rating: widget.rating),
      ),
    );
  }
}
