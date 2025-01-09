


class Video {
  final String id;
  final String title;
  final String videoUrl;
  final String description;
  final [String] comment;
  final DateTime createdAt;
  final int likeCount;
  final int commentCount;

  // 사용자 정보
  final String userId;
  final String userName;
  final String userProfileImage;

  // 추가 메타데이터
  final bool isLiked;
  
}