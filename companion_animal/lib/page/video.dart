import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  CameraController? _controller;  // null 허용
  Future<void>? _initializeControllerFuture;  // null 허용
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      final controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
        enableAudio: true,
      );

      _initializeControllerFuture = controller.initialize();
      
      if (mounted) {
        setState(() {
          _controller = controller;
        });
      }

      await _initializeControllerFuture;  // 초기화 완료 대기
    } catch (e) {
      print('카메라 초기화 오류: $e');
    }
  }

  Future<void> _toggleRecording() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    if (_isRecording) {
      final file = await _controller!.stopVideoRecording();
      setState(() => _isRecording = false);
      
      if (!mounted) return;
      
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VideoPreviewScreen(videoFile: file),
        ),
      );
    } else {
      await _controller!.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || _initializeControllerFuture == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller!),
                
                // 상단 컨트롤
                Positioned(
                  top: 40,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                        icon: const Icon(Icons.flip_camera_ios),
                        color: Colors.white,
                        onPressed: () async {
                          try {
                            final cameras = await availableCameras();
                            final newCamera = cameras.firstWhere(
                              (camera) => camera.lensDirection != 
                                _controller!.description.lensDirection,
                            );
                            
                            final controller = CameraController(
                              newCamera,
                              ResolutionPreset.high,
                              enableAudio: true,
                            );

                            await _controller?.dispose();
                            
                            _initializeControllerFuture = controller.initialize();
                            
                            if (mounted) {
                              setState(() {
                                _controller = controller;
                              });
                            }
                            
                            await _initializeControllerFuture;
                          } catch (e) {
                            print('카메라 전환 오류: $e');
                          }
                        },
                      ),
                    ],
                  ),
                ),
                
                // 하단 컨트롤
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _toggleRecording,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                            color: _isRecording ? Colors.red : Colors.transparent,
                          ),
                          child: Center(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _isRecording ? Colors.red : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// 비디오 미리보기 화면
class VideoPreviewScreen extends StatelessWidget {
  final XFile videoFile;

  const VideoPreviewScreen({super.key, required this.videoFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('미리보기'),
        actions: [
          TextButton(
            onPressed: () {
              // 업로드 로직 구현
            },
            child: const Text(
              '공유하기',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('비디오 경로: ${videoFile.path}'),
        // 실제 구현시 video_player 패키지를 사용하여 비디오 재생 구현
      ),
    );
  }
}



