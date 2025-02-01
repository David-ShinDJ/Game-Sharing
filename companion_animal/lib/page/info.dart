import 'package:flutter/material.dart';
import '../service/services.dart';
import '../model/models.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final UserService _userService = UserService();
  final PetVideoService _videoService = PetVideoService();
  late Future<User> _userFuture;
  late Future<List<PetVideo>> _userVideosFuture;

  @override
  void initState() {
    super.initState();
    // 임시로 'user1' ID 사용
    _userFuture = _userService.getUserInfo('user1');
    _userVideosFuture = _videoService.getUserVideos('user1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // 설정 페이지로 이동
            },
          ),
        ],
      ),
      body: FutureBuilder<User>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final user = snapshot.data!;

          return CustomScrollView(
            slivers: [
              // 프로필 정보
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 프로필 헤더
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(user.profileImageUrl),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  user.email,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // 게시물 수
                      Text(
                        '게시물 ${user.pets.length}개',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 반려동물 목록
                      const Text(
                        '나의 반려동물',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: user.pets.length,
                          itemBuilder: (context, index) {
                            final pet = user.pets[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(pet.imageUrl),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    pet.name,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    pet.breed,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 사용자 비디오 그리드
              FutureBuilder<List<PetVideo>>(
                future: _userVideosFuture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final videos = snapshot.data!;
                  return SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final video = videos[index];
                        return GestureDetector(
                          onTap: () {
                            // 비디오 상세 페이지로 이동
                          },
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                video.ownerProfileImage,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: 4,
                                right: 4,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      video.likeCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: videos.length,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}