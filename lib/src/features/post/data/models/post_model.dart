part of '../../post.dart';

// {
//         "id": 9,
//         "content": "JHipster is a development platform to generate, develop and deploy Spring Boot + Angular / React / Vue Web applications and Spring microservices.",
//         "createdAt": "2025-05-17T14:43:37Z",
//         "updatedAt": "2025-05-17T05:32:11Z",
//         "locationName": "indeed premium",
//         "locationLat": 9.68,
//         "locationLong": 165.97,
//         "privacy": "FRIENDS",
//         "scheduledAt": "2025-05-16T21:07:04Z",
//         "viewCount": null,
//         "commentCount": null,
//         "shareCount": null,
//         "reactionCount": null,
//         "user": null,
//         "tags": []
//     }

class PostModel {
  int? id;
  String? content;
  String? createdAt;
  String? updatedAt;
  String? locationName;
  double? locationLat;
  double? locationLong;
  String? privacy;
  String? scheduledAt;
  int? viewCount;
  int? commentCount;
  int? shareCount;
  int? reactionCount;
  PostOwner? user;
  List<PostTag>? tags;
  bool? isLiked;
  List<String>? files;

  PostModel({
    this.id,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.locationName,
    this.locationLat,
    this.locationLong,
    this.privacy,
    this.scheduledAt,
    this.viewCount,
    this.commentCount,
    this.shareCount,
    this.reactionCount,
    this.user,
    this.tags,
    this.isLiked,
    this.files,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      locationName: json['locationName'] as String?,
      locationLat: (json['locationLat'] as num?)?.toDouble(),
      locationLong: (json['locationLong'] as num?)?.toDouble(),
      privacy: json['privacy'] as String?,
      scheduledAt: json['scheduledAt'] as String?,
      viewCount: json['viewCount'] as int?,
      commentCount: json['commentCount'] as int?,
      shareCount: json['shareCount'] as int?,
      reactionCount: json['reactionCount'] as int?,
      user: json['user'] != null ? PostOwner.fromJson(json['user'] as Map<String, dynamic>) : null,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => PostTag.fromJson(e as Map<String, dynamic>)).toList(),
      isLiked: json['isLiked'] as bool?,
      files: (json['files'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'locationName': locationName,
      'locationLat': locationLat,
      'locationLong': locationLong,
      'privacy': privacy,
      'scheduledAt': scheduledAt,
      'viewCount': viewCount,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'reactionCount': reactionCount,
      'user': user?.toJson(),
      'tags': tags,
      'isLiked': isLiked,
      'files': files,
    };
  }

  @override
  String toString() {
    return 'PostModel{id: $id, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, locationName: $locationName, locationLat: $locationLat, locationLong: $locationLong, privacy: $privacy, scheduledAt: $scheduledAt, viewCount: $viewCount, commentCount: $commentCount, shareCount: $shareCount, reactionCount: $reactionCount, user: $user, tags: $tags, isLiked: $isLiked, files: $files}';
  }
}

class PostOwner {
  int? id;
  String? username;
  String? imageUrl;

  PostOwner({this.id, this.username, this.imageUrl});

  factory PostOwner.fromJson(Map<String, dynamic> json) {
    return PostOwner(
      id: json['id'] as int?,
      username: json['login'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'imageUrl': imageUrl,
    };
  }
}

class PostTag {
  int? id;
  String? name;

  PostTag({this.id, this.name});

  factory PostTag.fromJson(Map<String, dynamic> json) {
    return PostTag(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
