import 'package:flutter/material.dart';

enum PostSize { big, medium, small, tiny }

abstract class PostModel {
  const PostModel({
    required this.postImageProvider,
    required this.createdAt,
    this.finalRate = 0.0,
  });

  final double finalRate;

  final ImageProvider postImageProvider;
  final DateTime createdAt;

  factory PostModel.fromMap(Map<String, dynamic> map) {
    if (map['final_rate'] != null) {
      return RatedPost(
        postImageProvider: NetworkImage(map['post_image'] ?? ''),
        createdAt: DateTime.parse(map['upload_date'] ?? ''),
        finalRate: map['final_rate'],
      );
    } else {
      return UnratedPost(
        postImageProvider: NetworkImage(map['post_image'] ?? ''),
        createdAt: DateTime.parse(map['created_at'] ?? ''),
        ratingCount: map['rating_count'],
        totalRate: map['total_rate'],
        lastRateTimestamp: DateTime.parse(map['last_rate_timestamp'] ?? ''),
      );
    }
  }

  Map<String, dynamic> toMap();
}

class RatedPost extends PostModel {
  RatedPost({
    required super.postImageProvider,
    required super.createdAt,
    required super.finalRate,
  });

  get postSize {
    if (finalRate >= 0.75) return PostSize.big;
    if (finalRate >= 0.5) return PostSize.medium;
    if (finalRate >= 0.25) return PostSize.small;
    return PostSize.tiny;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'post_image': postImageProvider,
      'upload_date': createdAt,
      'final_rate': finalRate,
    };
  }
}

class UnratedPost extends PostModel {
  UnratedPost({
    required super.postImageProvider,
    required super.createdAt,
    required this.ratingCount,
    required this.totalRate,
    required this.lastRateTimestamp,
  });

  final int ratingCount;
  final double totalRate;
  final DateTime lastRateTimestamp;

  @override
  Map<String, dynamic> toMap() {
    return {
      'post_image': postImageProvider,
      'created_at': createdAt,
      'rating_count': ratingCount,
      'total_rate': totalRate,
      'last_rate_timestamp': lastRateTimestamp,
    };
  }
}
