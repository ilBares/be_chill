import 'package:be_chill/src/domain/entities/post_model.dart';
import 'package:be_chill/src/presentation/common/vertical_widget.dart';
import 'package:be_chill/src/presentation/widgets/post_grid_section.dart';
import 'package:flutter/material.dart';

final List<PostModel> posts = [
  RatedPost(
    finalRate: 0.92,
    createdAt: DateTime.timestamp(),
    postImageProvider: const AssetImage('assets/images/post_1.jpeg'),
  ),
  RatedPost(
    finalRate: 0.89,
    createdAt: DateTime.timestamp(),
    postImageProvider: const AssetImage('assets/images/post_5.jpeg'),
  ),
  RatedPost(
    finalRate: 0.88,
    createdAt: DateTime.timestamp(),
    postImageProvider: const AssetImage('assets/images/post_3.jpeg'),
  ),
  RatedPost(
    finalRate: 0.85,
    createdAt: DateTime.timestamp(),
    postImageProvider: const AssetImage('assets/images/post_4.jpeg'),
  ),
  RatedPost(
    finalRate: 0.85,
    createdAt: DateTime.timestamp(),
    postImageProvider: const AssetImage('assets/images/post_large.jpeg'),
  ),
  RatedPost(
    finalRate: 0.84,
    createdAt: DateTime.timestamp(),
    postImageProvider: const AssetImage('assets/images/post_2.jpeg'),
  ),
];

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: PostGridSection.ranking(posts),
              ),
            ),
          ),
          const VerticalText(
            alignment: Alignment.centerLeft,
            text: "PROFILE",
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}
