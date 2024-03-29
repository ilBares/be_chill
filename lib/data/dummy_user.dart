import 'package:be_chill/src/domain/entities/post_model.dart';
import 'package:be_chill/src/domain/entities/user_model.dart';
import 'package:flutter/material.dart';

String description = '''
Student at the University of Brescia pursuing a degree in Computer Engineering.
Web Programmer at Intersail Engineering.
''';

List<PostModel> posts = [
  RatedPost(
    finalRate: 0.85,
    createdAt: DateTime.timestamp(),
    postImageProvider: const AssetImage('assets/images/fake_2.jpeg'),
  ),
  // RatedPost(
  //   finalRate: 0.8,
  //   createdAt: DateTime.timestamp(),
  //   postImageProvider: const AssetImage('assets/images/post_large_2.jpeg'),
  // ),
  // RatedPost(
  //   finalRate: 0.75,
  //   createdAt: DateTime.timestamp(),
  //   postImageProvider: const AssetImage('assets/images/post_large_3.jpeg'),
  // ),
  RatedPost(
    finalRate: 0.55,
    createdAt: DateTime.timestamp(),
    postImageProvider: const AssetImage('assets/images/fake_3.jpeg'),
  ),
  RatedPost(
    finalRate: 0.4,
    createdAt: DateTime.timestamp(),
    postImageProvider: const AssetImage('assets/images/fake_4.jpeg'),
  ),
  RatedPost(
    finalRate: 0.2,
    createdAt: DateTime.timestamp(),
    postImageProvider: const AssetImage('assets/images/post_tiny_1.jpeg'),
  ),
];

UserModel user = UserModel(
  uid: '1',
  createdAt: DateTime.now(),
  averageRate: 0.6,
  phoneNumber: '3667097756',
  username: 'marcobare',
  profilePicUrl:
      'https://media.licdn.com/dms/image/D4E03AQEVFqs6S1GKhw/profile-displayphoto-shrink_800_800/0/1694442545215?e=2147483647&v=beta&t=92kL2oUeRWlJLkT2hLceunvarY103jrPHW3qz53mWDg',
  birthday: DateTime(2001, 3, 10),
  bio: description,
  posts: posts,
);
