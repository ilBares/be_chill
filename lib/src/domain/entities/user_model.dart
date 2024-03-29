// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:be_chill/src/domain/entities/post_model.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  UserModel({
    required this.createdAt,
    required this.phoneNumber,
    required this.username,
    required this.birthday,
    required this.bio,
    this.averageRate = 0.0,
    this.uid,
    this.version = 0,
    this.posts = const <PostModel>[],
    this.profilePicUrl = "",
  });

  final DateTime createdAt;
  final String phoneNumber;
  final String username;
  final DateTime birthday;
  final String bio;
  final double averageRate;
  int version;
  String? uid;
  String? profilePicUrl;
  List<PostModel> posts;

  set setProfilePicUrl(String? newProfilePicUrl) {
    profilePicUrl = newProfilePicUrl;
  }

  set setUid(String? newUid) {
    uid = newUid;
  }

  set setVersion(int newVersion) {
    version = newVersion;
  }

  set setPosts(List<PostModel> newPosts) {
    posts = newPosts;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'phoneNumber': phoneNumber,
      'username': username,
      'profilePicUrl': profilePicUrl,
      'birthday': birthday.millisecondsSinceEpoch,
      'bio': bio,
      'posts': posts.map((x) => x.toMap()).toList(),
      'averageRate': averageRate,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      phoneNumber: map['phoneNumber'] as String,
      username: map['username'] as String,
      profilePicUrl:
          map['profilePicUrl'] != null ? map['profilePicUrl'] as String : null,
      birthday: DateTime.fromMillisecondsSinceEpoch(map['birthday'] as int),
      bio: map['bio'] as String,
      posts: const <PostModel>[],
      // List<PostModel>.from(
      //   (map['posts'] as List<PostModel>).map<PostModel>(
      //     (x) => PostModel.fromMap(x as Map<String, dynamic>),
      //   ),
      // ),
      averageRate: map['averageRate'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  UserModel copyWith({
    String? uid,
    DateTime? createdAt,
    String? phoneNumber,
    String? username,
    String? profilePicUrl,
    DateTime? birthday,
    String? bio,
    double? averageRate,
    int? version,
    List<PostModel>? posts,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username ?? this.username,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      birthday: birthday ?? this.birthday,
      bio: bio ?? this.bio,
      averageRate: averageRate ?? this.averageRate,
      version: version ?? this.version,
      posts: posts ?? this.posts,
    );
  }

  @override
  String toString() {
    return 'User(uid: $uid, createdAt: $createdAt, phoneNumber: $phoneNumber, username: $username, profilePicUrl: $profilePicUrl, birthday: $birthday, bio: $bio, posts: $posts, averageRate: $averageRate)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.createdAt == createdAt &&
        other.phoneNumber == phoneNumber &&
        other.username == username &&
        other.profilePicUrl == profilePicUrl &&
        other.birthday == birthday &&
        other.bio == bio &&
        listEquals(other.posts, posts) &&
        other.averageRate == averageRate;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        createdAt.hashCode ^
        phoneNumber.hashCode ^
        username.hashCode ^
        profilePicUrl.hashCode ^
        birthday.hashCode ^
        bio.hashCode ^
        posts.hashCode ^
        averageRate.hashCode;
  }
}
