class PetVideo {
  final String id;
  final String videoUrl;
  final String petName;        // 반려동물 이름
  final String petType;        // 동물 종류 (강아지, 고양이 등)
  final String breed;          // 품종
  final String description;    // 영상 설명
  final DateTime createdAt;
  final int likeCount;
  final int commentCount;
  
  // 반려동물 주인 정보
  final String ownerId;
  final String ownerName;
  final String ownerProfileImage;
  
  // 영상 태그 및 카테고리
  final List<String> tags;     // #귀여움 #재미있는 등
  
  // 상호작용 상태
  final bool isLiked;

  const PetVideo({
    required this.id,
    required this.videoUrl,
    required this.petName,
    required this.petType,
    required this.breed,
    required this.description,
    required this.createdAt,
    required this.likeCount,
    required this.commentCount,
    required this.ownerId,
    required this.ownerName,
    required this.ownerProfileImage,
    required this.tags,
    this.isLiked = false,
  });

  // JSON에서 객체 생성
  factory PetVideo.fromJson(Map<String, dynamic> json) => PetVideo(
    id: json['id'] as String,
    videoUrl: json['videoUrl'] as String,
    petName: json['petName'] as String,
    petType: json['petType'] as String,
    breed: json['breed'] as String,
    description: json['description'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    likeCount: json['likeCount'] as int,
    commentCount: json['commentCount'] as int,
    ownerId: json['ownerId'] as String,
    ownerName: json['ownerName'] as String,
    ownerProfileImage: json['ownerProfileImage'] as String,
    tags: json['tags'] as List<String>,
    isLiked: json['isLiked'] as bool,

    
  );

  // JSON으로 변환
  Map<String, Object?> toJson() => {
    'id': id,
    'videoUrl': videoUrl,
    'petName': petName,
    'petType': petType,
    'breed': breed,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
    'likeCount': likeCount,
    'commentCount': commentCount,
    'ownerId': ownerId,
    'ownerName': ownerName,
    'ownerProfileImage': ownerProfileImage,
    'tags': tags,
    'isLiked': isLiked,
  };

  // copyWith 메서드
  PetVideo copyWith({
    String? id,
    String? videoUrl,
    String? petName,
    String? petType,
    String? breed,
    String? description,
    DateTime? createdAt,
    int? likeCount,
    int? commentCount,
    String? ownerId,
    String? ownerName,
    String? ownerProfileImage,
    List<String>? tags, 
    bool? isLiked,
  }) => PetVideo(
    id: id ?? this.id,
    videoUrl: videoUrl ?? this.videoUrl,
    petName: petName ?? this.petName,
    petType: petType ?? this.petType,
    breed: breed ?? this.breed,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    likeCount: likeCount ?? this.likeCount,
    commentCount: commentCount ?? this.commentCount,
    ownerId: ownerId ?? this.ownerId,
    ownerName: ownerName ?? this.ownerName,
    ownerProfileImage: ownerProfileImage ?? this.ownerProfileImage,
    tags: tags ?? this.tags,
    isLiked: isLiked ?? this.isLiked,
  );
  // ... fromJson, toJson, copyWith 메서드는 동일한 패턴으로 구현
}

class User {
  final String id;
  final String name;
  final String email;
  final String profileImageUrl;
  
  // 반려동물 관련 정보
  final List<Pet> pets;          // 사용자의 반려동물 목록
  
  // 활동 이력
  final List<String> likedVideoIds;    // 좋아요한 비디오 ID 목록
  final List<Comment> comments;    // 작성한 댓글 목록
  final int totalLikes;           // 받은 총 좋아요 수
  
  // 팔로우 정보
  final int followerCount;
  final int followingCount;
  
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    this.pets = const [],
    this.likedVideoIds = const [],
    this.comments = const [],
    this.totalLikes = 0,
    this.followerCount = 0,
    this.followingCount = 0,
  });
  
  // JSON에서 객체 생성
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    profileImageUrl: json['profileImageUrl'] as String,
    pets: json['pets'] as List<Pet>,
    likedVideoIds: json['likedVideoIds'] as List<String>,
    comments: json['comments'] as List<Comment>,
    totalLikes: json['totalLikes'] as int,
    followerCount: json['followerCount'] as int,
    followingCount: json['followingCount'] as int,
  );
  // JSON으로 변환
  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'profileImageUrl': profileImageUrl,
    'pets': pets.map((pet) => pet.toJson()).toList(),
    'likedVideoIds': likedVideoIds,
    'comments': comments.map((comment) => comment.toJson()).toList(),
    'totalLikes': totalLikes,
    'followerCount': followerCount,
    'followingCount': followingCount,
  };  

  // copyWith 메서드
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImageUrl,
    List<Pet>? pets,
    List<String>? likedVideoIds,
    List<Comment>? comments,
    int? totalLikes,
    int? followerCount,
    int? followingCount,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email ?? this.email,
    profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    pets: pets ?? this.pets,
    likedVideoIds: likedVideoIds ?? this.likedVideoIds,
    comments: comments ?? this.comments,
    totalLikes: totalLikes ?? this.totalLikes,
    followerCount: followerCount ?? this.followerCount,
    followingCount: followingCount ?? this.followingCount,
  );
}

// 반려동물 정보를 위한 별도 클래스
class Pet {
  final String id;
  final String name;
  final String type;    // 강아지, 고양이 등
  final String breed;   // 품종
  final String imageUrl;
  final DateTime birthDate;

  const Pet({
    required this.id,
    required this.name,
    required this.type,
    required this.breed,
    required this.imageUrl,
    required this.birthDate,
  });

  // JSON에서 객체 생성
  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
    id: json['id'] as String,
    name: json['name'] as String,
    type: json['type'] as String,
    breed: json['breed'] as String,
    imageUrl: json['imageUrl'] as String,
    birthDate: DateTime.parse(json['birthDate'] as String),
  );

  // JSON으로 변환  
  Map<String, Object?> toJson() => {
    'id': id,
    'name': name,
    'type': type,
    'breed': breed,
    'imageUrl': imageUrl,
    'birthDate': birthDate.toIso8601String(),
  };

  // copyWith 메서드
  Pet copyWith({
    String? id,
    String? name,
    String? type,
    String? breed,
    String? imageUrl,
    DateTime? birthDate,        
  }) => Pet(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    breed: breed ?? this.breed,
    imageUrl: imageUrl ?? this.imageUrl,  
    birthDate: birthDate ?? this.birthDate,
  );
}

// 댓글 정보를 위한 클래스
class Comment {
  final String id;
  final String videoId;
  final String userId;      // 댓글 작성자 ID
  final String userName;    // 댓글 작성자 이름
  final String userProfileImage; // 작성자 프로필 이미지
  final String content;     // 댓글 내용
  final DateTime createdAt;
  final String? parentId;   // 부모 댓글 ID (대댓글인 경우)
  final List<Comment> replies; // 대댓글 목록

  const Comment({
    required this.id,
    required this.videoId,
    required this.userId,
    required this.userName,
    required this.userProfileImage,
    required this.content,
    required this.createdAt,
    this.parentId,
    this.replies = const [],
  });

  // JSON에서 객체 생성
  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json['id'] as String,
    videoId: json['videoId'] as String,
    userId: json['userId'] as String,
    userName: json['userName'] as String,
    userProfileImage: json['userProfileImage'] as String,
    content: json['content'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    parentId: json['parentId'] as String?,
    replies: (json['replies'] as List<dynamic>?)
        ?.map((reply) => Comment.fromJson(reply as Map<String, dynamic>))
        .toList() ?? [],
  );

  // JSON으로 변환
  Map<String, Object?> toJson() => {
    'id': id,
    'videoId': videoId,
    'userId': userId,
    'userName': userName,
    'userProfileImage': userProfileImage,
    'content': content,
    'createdAt': createdAt.toIso8601String(),
    'parentId': parentId,
    'replies': replies.map((reply) => reply.toJson()).toList(),
  };

  // copyWith 메서드
  Comment copyWith({
    String? id,
    String? videoId,
    String? userId,
    String? userName,
    String? userProfileImage,
    String? content,
    DateTime? createdAt,
    String? parentId,
    List<Comment>? replies,
  }) => Comment(
    id: id ?? this.id,
    videoId: videoId ?? this.videoId,
    userId: userId ?? this.userId,
    userName: userName ?? this.userName,
    userProfileImage: userProfileImage ?? this.userProfileImage,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
    parentId: parentId ?? this.parentId,
    replies: replies ?? this.replies,
  );
}

// 일반 댓글
Comment mainComment = Comment(
  id: 'comment1',
  videoId: 'video1',
  userId: 'user1',
  userName: '김멍멍',
  userProfileImage: 'profile1.jpg',
  content: '귀여워요!',
  createdAt: DateTime.now(),
  replies: [
    // 대댓글
    Comment(
      id: 'reply1',
      videoId: 'video1',
      userId: 'user2',
      userName: '박냥냥',
      userProfileImage: 'profile2.jpg',
      content: '저도 그렇게 생각해요!',
      createdAt: DateTime.now(),
      parentId: 'comment1', // 부모 댓글 ID 지정
    ),
  ],
);