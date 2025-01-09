import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final List<VideoPlayerController> _controllers = [];
  int currentPlayingIndex = 0;
  bool showControls = false;

  @override
  void initState() {
    super.initState();
    // 초기 비디오 컨트롤러 생성
    for (int i = 0; i < 5; i++) {
      final controller = VideoPlayerController.asset('assets/video/video_$i.mp4');
      _controllers.add(controller);
      controller.initialize().then((_) {
        setState(() {});
      });
    }
    _controllers[0].play();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Companion Animal"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // 좋아요 기능 구현
            },
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              // 메시지 보내기 기능 구현
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // 더보기 기능 구현
            },
          ),
        ],
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          _controllers[currentPlayingIndex].pause();
          _controllers[index].play();
          setState(() {
            currentPlayingIndex = index;
          });
        },
        itemCount: _controllers.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showControls = !showControls;
                                
                                if (showControls) {
                                  Future.delayed(Duration(seconds: 3), () {
                                    if (mounted) {
                                      setState(() {
                                        showControls = false;
                                      });
                                    }
                                  });
                                }
                              });
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                VideoPlayer(_controllers[index]),
                                if (showControls)
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            _controllers[index].value.isPlaying 
                                                ? Icons.pause 
                                                : Icons.play_arrow,
                                            color: Colors.white,
                                            size: 50.0,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (_controllers[index].value.isPlaying) {
                                                _controllers[index].pause();
                                              } else {
                                                _controllers[index].play();
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (index != currentPlayingIndex)
                    Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: AspectRatio(
                          aspectRatio: _controllers[index].value.aspectRatio,
                          child: VideoPlayer(_controllers[index]),
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite_border),
                        SizedBox(width: 8),
                        Text('1.2K'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.comment_outlined),
                        SizedBox(width: 8),
                        Text('234'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.share_outlined),
                        SizedBox(width: 8),
                        Text('Share'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}