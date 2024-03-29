import 'package:be_chill/src/domain/entities/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:be_chill/src/presentation/widgets/post_tile.dart';
import 'package:transparent_image/transparent_image.dart';

enum PostGridType {
  profile,
  ranking,
}

/// A widget that displays a grid of posts in a staggered layout.
///
/// The [PostGridSection] widget takes a list of [Post] objects and displays them
/// in a grid layout using the [StaggeredGrid.count] widget. The posts are sorted
/// based on their final rate and upload date.
///
/// The grid layout has a cross axis count of 4 and spacing between the main axis
/// and cross axis. Each post is displayed using the [PostTile] widget, which
/// varies in size based on the [PostSize] of the post.
///
/// If a post is an [UnratedPost], it is displayed as a tiny tile with a rating of 0.0.
/// If a post is a [RatedPost] with a [PostSize] of [PostSize.big], it is displayed
/// as a large tile. If the [PostSize] is [PostSize.medium], it is displayed as a
/// medium tile. If the [PostSize] is [PostSize.small], it is displayed as a small tile.
/// If the [PostSize] is not specified or invalid, it is displayed as a tiny tile.
///
/// The [PostTile.add] widget is also included in the grid to allow adding new posts.
class PostGridSection extends StatelessWidget {
  const PostGridSection.profile(this.posts, {super.key})
      : type = PostGridType.profile;

  const PostGridSection.ranking(this.posts, {super.key})
      : type = PostGridType.ranking;

  final List<PostModel> posts;
  final PostGridType type;

  @override
  Widget build(BuildContext context) {
    List<PostModel> postsCpy = List.from(posts);
    postsCpy.sort((postA, postB) {
      final comparison = postB.finalRate.compareTo(postA.finalRate);
      return comparison != 0
          ? comparison
          : postB.createdAt.compareTo(postA.createdAt);
    });

    return SingleChildScrollView(
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: [
          if (type == PostGridType.ranking)
            // TODO
            StaggeredGridTile.count(
              crossAxisCellCount: 2,
              mainAxisCellCount: 2,
              child: Image.asset(
                'assets/images/trophy.png',
                fit: BoxFit.cover,
              ),
            ),
          ...postsCpy.map((p) {
            FadeInImage img = FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              fadeInDuration: const Duration(milliseconds: 300),
              fadeInCurve: Curves.easeIn,
              key: ValueKey(p.hashCode),
              image: p.postImageProvider,
            );

            if (p is UnratedPost) {
              return PostTile.tiny(
                rating: 0.0,
                child: img,
              );
            }

            switch ((p as RatedPost).postSize) {
              case PostSize.big:
                return PostTile.large(
                  rating: p.finalRate,
                  child: img,
                );
              case PostSize.medium:
                return PostTile.medium(
                  rating: p.finalRate,
                  child: img,
                );
              case PostSize.small:
                return PostTile.small(
                  rating: p.finalRate,
                  child: img,
                );
              default:
                return PostTile.tiny(
                  rating: p.finalRate,
                  child: img,
                );
            }
          }),
          if (type == PostGridType.profile) const PostTile.add(),
          const SizedBox(height: 48.0),
        ],
      ),
    );
  }
}
