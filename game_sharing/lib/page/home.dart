import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'Messages',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        HomePage(),
        SecondPage(),
        ThirdPage(),


      ][currentPageIndex],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView( // 스크롤 가능하도록 SingleChildScrollView 추가
              child: Column(
                children: [
                  // 상단 프로필 정보
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('images/user.png'), // 프로필 이미지 경로
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'nanna_919',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text('내 스토리'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  // 이미지
                  Image.asset('images/game.png'), // 게시글 이미지 경로
                  // 좋아요, 댓글 등 아이콘 버튼
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.chat_bubble_outline),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(Icons.send),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(Icons.bookmark_border),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  // 좋아요 정보
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text(
                          '좋아요 1,234개',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  // 게시글 내용
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'nanna_919 ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: '같은 오늘 그냥 지나칠 수 없기에...'),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text('신을 진심으로...'),
                        SizedBox(height: 8),
                        Text(
                          '정성으로 길러주신 은혜에 감사드립니다. 어머니가 있었기에 오늘의 제가 있습니다. 사랑합니다. 오래 오래 행복하고 건강하게 우리와 함께 해주세요 ❤️',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 8),
                        Text(
                          '- 사랑하는 가족 일동 -',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  // 댓글
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '댓글 5개 모두 보기',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  // 댓글 입력창
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage('images/user.png'), // 프로필 이미지 경로
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '댓글 달기...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  // 게시 시간
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '13시간 전',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Second Page"),);
  }
}
class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Third Page"),);
  }
}

