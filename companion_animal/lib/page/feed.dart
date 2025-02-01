import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../service/services.dart';
import '../model/models.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PetVideoService _petVideoService = PetVideoService();
  final List<VideoPlayerController> _controllers = [];
  List<PetVideo> _petVideos = [];
  int currentPlayingIndex = 0;
  bool showControls = false;
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _initializePetVideos();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // 방법 1: 한 번에 전체 비디오 로드하기
  Future<void> _initializePetVideos() async {
    try {
      setState(() => _isLoading = true);

      // 전체 비디오 데이터 가져오기
      _petVideos = await _petVideoService.getPetVideoFeed();

      // 컨트롤러 초기화
      for (var video in _petVideos) {
        final controller = VideoPlayerController.asset(video.videoUrl);
        _controllers.add(controller);
        await controller.initialize();
      }

      if (_controllers.isNotEmpty) {
        _controllers[0].play();
      }
    } catch (e) {
      print("Error initializing pet videos: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleVideoTap() {
    setState(() {
      showControls = !showControls;
      
      if (showControls) {
        Future.delayed(Duration(seconds: 3), () {
          if (mounted) {
            setState(() => showControls = false);
          }
        });
      }
    });
  }

  void _handleLike() {
    // 좋아요 기능 구현
  }

  void _handleComment() {
    // 댓글 기능 구현
  }


//TODO: 추후에 비디오로드 페이지네션방법으로 LIMIT 가져오게 수정하기
  // // 방법 2: 스크롤 하면서 비디오 로드하기
  // int _currentPage = 1;
  // bool _hasMore = true;
  // static const int _pageSize = 5;

  // Future<void> _loadMoreVideos() async {
  //   if (!_hasMore || _isLoading) return;

  //   try {
  //     setState(() => _isLoading = true);

  //     // 페이지별로 비디오 가져오기 -> 페이지네이션 적용 전체 비디오 로드하는게 아니라 10개씩 LIMIT 적용
  //     final newVideos = await _petVideoService.getPetVideoFeedPaginated(
  //       _currentPage,
  //       _pageSize
  //     );

  //     if (newVideos.isEmpty) {
  //       _hasMore = false;
  //       return;
  //     }

  //     // 새 비디오의 컨트롤러 초기화
  //     for (var video in newVideos) {
  //       final controller = VideoPlayerController.asset(video.videoUrl);
  //       _controllers.add(controller);
  //       await controller.initialize();
  //     }

  //     setState(() {
  //       _petVideos.addAll(newVideos);
  //       _currentPage++;
  //     });
  //   } catch (e) {
  //     print("Error loading more videos: $e");
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }

  // }

  @override
  Widget build(BuildContext context) {
    if  (_isLoading) { return const Scaffold(body: Center(child: CircularProgressIndicator()));}

    return Scaffold(
      appBar: AppBar(
        title: const Text("펫비디오"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            //TODO: 추후에 좋아요 기능 구현
            onPressed: () {
              // 좋아요 목록 페이지 이동
            },
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: () {
            // 영상 공유 기능 구현
          }),
        ]
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          _controllers[currentPlayingIndex].pause();
          _controllers[index].play();
          setState(() {
            currentPlayingIndex = index;
            showControls = false;
          });
        },
        itemCount: _petVideos.length,
        itemBuilder: (context, index) => VideoItem(
          video: _petVideos[index],
          controller: _controllers[index],
          showControls: showControls,
          onTap: () => _handleVideoTap(),
          onLike: () => _handleLike(),
          onComment: () => _handleComment(),
        ),
      )
    );
  }
}

// UI 표현을 담당하는 StatelessWidget
class VideoItem extends StatelessWidget {
  final PetVideo video;
  final VideoPlayerController controller;
  final bool showControls;
  final VoidCallback onTap;
  final VoidCallback onLike;
  final VoidCallback onComment;

  const VideoItem({
    super.key,
    required this.video,
    required this.controller,
    required this.showControls,
    required this.onTap,
    required this.onLike,
    required this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.black,
        child: Column(
          children: [
            // 비디오 컨테이너 (화면 높이의 85%)
            Expanded(  // Container를 Expanded로 변경
              flex: 85,  // 85%의 비중
              child: Stack(
                children: [
                  // 비디오 플레이어
                  Center(
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: controller.value.size.width,
                          height: controller.value.size.height,
                          child: VideoPlayer(controller),
                        ),
                      ),
                    ),
                  ),
                  
                  // 컨트롤 오버레이
                  if (showControls)
                    Container(
                      color: Colors.black26,
                      child: VideoControls(
                        onLike: onLike,
                        onComment: onComment,
                        isPlaying: controller.value.isPlaying,
                        onPlayPause: () {
                          if (controller.value.isPlaying) {
                            controller.pause();
                          } else {
                            controller.play();
                          }
                        },
                      ),
                    ),
                  
                  // 하단 정보 박스
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // CircleAvatar 임시 대체
                              CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person, color: Colors.white),
                                radius: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(  // Column을 Expanded로 감싸기
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      video.ownerName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      video.petName,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Follow',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            video.description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: video.tags.map((tag) => Text(
                              tag,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            )).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // 다음 영상 썸네일 미리보기
            Expanded(  // Container를 Expanded로 변경
              flex: 15,  // 15%의 비중
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black,
                    ],
                  ),
                ),
                child: const Center(
                  child: Text(
                    '다음 영상',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 더 작은 단위의 StatelessWidget들
class VideoControls extends StatelessWidget {
  final VoidCallback onLike;
  final VoidCallback onComment;
  final bool isPlaying;
  final VoidCallback onPlayPause;

  const VideoControls({
    required this.onLike,
    required this.onComment,
    required this.isPlaying,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.favorite),
          onPressed: onLike,
        ),
        IconButton(
          icon: Icon(Icons.comment),
          onPressed: onComment,
        ),
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: onPlayPause,
        ),
      ],
    );
  }
}
