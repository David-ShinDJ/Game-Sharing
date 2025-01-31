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