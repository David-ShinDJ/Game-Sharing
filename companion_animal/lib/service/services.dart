import 'package:companion_animal/global/database.dart';
import 'package:companion_animal/model/models.dart';

class PetVideoService {
  static final PetVideoService _instance = PetVideoService._internal();
  factory PetVideoService() => _instance;
  PetVideoService._internal();

  // 전체 비디오 피드 가져오기
  Future<List<PetVideo>> getPetVideoFeed() async {
    // 더미 데이터 반환
    return DummyData.videos;
  }

  // 페이지별로 비디오 가져오기
  Future<List<PetVideo>> getPetVideoFeedPaginated(int page, int pageSize) async {
    final videos = await getPetVideoFeed();
    return videos.skip(page * pageSize).take(pageSize).toList();
  }

  // 특정 반려동물 종류별 비디오 가져오기
  Future<List<PetVideo>> getVideosByPetType(String petType) async {
    final videos = await getPetVideoFeed();
    return videos.where((video) => video.petType == petType).toList();
  }

  // 인기 비디오 가져오기 (좋아요 순)
  Future<List<PetVideo>> getTrendingVideos() async {
    final videos = await getPetVideoFeed();
    return videos..sort((a, b) => b.likeCount.compareTo(a.likeCount));
  }

  // 특정 비디오의 댓글 가져오기
  Future<List<Comment>> getVideoComments(String videoId) async {
    return DummyData.comments
        .where((comment) => comment.videoId == videoId)
        .toList();
  }

  // 특정 사용자의 비디오 가져오기
  Future<List<PetVideo>> getUserVideos(String userId) async {
    final videos = await getPetVideoFeed();
    return videos.where((video) => video.ownerId == userId).toList();
  }

  // 최신 비디오 가져오기
  Future<List<PetVideo>> getLatestVideos() async {
    final videos = await getPetVideoFeed();
    return videos..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  // 태그로 비디오 검색
  Future<List<PetVideo>> searchVideosByTag(String tag) async {
    final videos = await getPetVideoFeed();
    return videos.where((video) => video.tags.contains(tag)).toList();
  }

  // 품종별 비디오 가져오기
  Future<List<PetVideo>> getVideosByBreed(String breed) async {
    final videos = await getPetVideoFeed();
    return videos.where((video) => video.breed == breed).toList();
  }
} 
class UserService {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  // 특정 사용자 정보 가져오기
  Future<User> getUserInfo(String userId) async {
    return DummyData.users.firstWhere((user) => user.id == userId);
  }

  // 사용자의 반려동물 목록 가져오기
  Future<List<Pet>> getUserPets(String userId) async {
    final user = await getUserInfo(userId);
    return user.pets;
  }


  // 특정 반려동물 종류를 키우는 사용자 목록
  Future<List<User>> getUsersByPetType(String petType) async {
    return DummyData.users
        .where((user) => user.pets.any((pet) => pet.type == petType))
        .toList();
  }

  // 사용자 검색 (이름으로)
  Future<List<User>> searchUsers(String query) async {
    return DummyData.users
        .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}


class CommentService {
  static final CommentService _instance = CommentService._internal();
  factory CommentService() => _instance;
  CommentService._internal();

  // 특정 비디오의 모든 댓글 가져오기
  Future<List<Comment>> getVideoComments(String videoId) async {
    return DummyData.comments
        .where((comment) => comment.videoId == videoId && comment.parentId == null)
        .toList();
  }

  // 특정 댓글의 대댓글 가져오기
  Future<List<Comment>> getReplies(String commentId) async {
    final parentComment = DummyData.comments
        .firstWhere((comment) => comment.id == commentId);
    return parentComment.replies;
  }

  // 특정 사용자가 작성한 모든 댓글 가져오기
  Future<List<Comment>> getUserComments(String userId) async {
    return DummyData.comments
        .where((comment) => comment.userId == userId)
        .toList();
  }

  // 최신 댓글순으로 가져오기
  Future<List<Comment>> getLatestComments(String videoId) async {
    final comments = await getVideoComments(videoId);
    return comments..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  // 댓글 추가하기 (실제로는 서버에 저장되어야 함)
  Future<Comment> addComment({
    required String videoId,
    required String userId,
    required String content,
    String? parentId,
  }) async {
    // 댓글 작성자 정보 가져오기
    final user = DummyData.users.firstWhere((user) => user.id == userId);
    
    final newComment = Comment(
      id: 'comment${DateTime.now().millisecondsSinceEpoch}',
      videoId: videoId,
      userId: userId,
      userName: user.name,
      userProfileImage: user.profileImageUrl,
      content: content,
      createdAt: DateTime.now(),
      parentId: parentId,
    );

    // 실제 구현에서는 서버에 저장
    return newComment;
  }

  // 댓글 삭제하기 (실제로는 서버에서 삭제되어야 함)
  Future<void> deleteComment(String commentId) async {
    // 실제 구현에서는 서버에서 삭제
  }
}

class PetService {
  static final PetService _instance = PetService._internal();
  factory PetService() => _instance;
  PetService._internal();

  // 모든 반려동물 목록 가져오기
  Future<List<Pet>> getAllPets() async {
    return DummyData.pets;
  }

  // 특정 반려동물 정보 가져오기
  Future<Pet> getPetInfo(String petId) async {
    return DummyData.pets.firstWhere((pet) => pet.id == petId);
  }

  // 동물 종류별 반려동물 가져오기
  Future<List<Pet>> getPetsByType(String type) async {
    return DummyData.pets.where((pet) => pet.type == type).toList();
  }

  // 품종별 반려동물 가져오기
  Future<List<Pet>> getPetsByBreed(String breed) async {
    return DummyData.pets.where((pet) => pet.breed == breed).toList();
  }

  // 나이순으로 반려동물 정렬하기
  Future<List<Pet>> getPetsSortedByAge() async {
    final pets = await getAllPets();
    return pets..sort((a, b) => a.birthDate.compareTo(b.birthDate));
  }
}

