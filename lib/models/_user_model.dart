import 'package:be_chill/src/domain/entities/post_model.dart';

class UserModel {
  UserModel({
    required this.uid,
    required this.createdAt,
    required this.phoneNumber,
    required this.username,
    required this.profilePicUrl,
    required this.birthday,
    required this.bio,
    required this.posts,
    this.averageRate = 0.0,
  });

  String uid;
  DateTime createdAt;
  String phoneNumber;
  String username;
  String? profilePicUrl;
  DateTime birthday;
  String bio;
  List<PostModel> posts;
  double averageRate;
  // SETTINGS

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      createdAt: DateTime.parse(map['created_at'] ?? ''),
      phoneNumber: map['phone_number'] ?? '',
      username: map['username'] ?? '',
      profilePicUrl: map['profile_pic_url'] ?? '',
      birthday: DateTime.parse(map['birthday'] ?? ''),
      bio: map['bio'] ?? '',
      posts:
          List<PostModel>.from(map['posts'].map((x) => PostModel.fromMap(x))),
      averageRate: map['average_rate'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'created_at': createdAt.toIso8601String(),
      'phone_number': phoneNumber,
      'username': username,
      'profile_pic_url': profilePicUrl,
      'birthday': birthday.toIso8601String(),
      'bio': bio,
      'posts': posts.map((p) => p.toMap()).toList(),
      'average_rate': averageRate,
    };
  }
}
