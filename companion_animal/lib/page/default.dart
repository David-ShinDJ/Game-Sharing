import 'package:flutter/material.dart';
import 'video.dart';
import 'feed.dart';
import 'info.dart';

class DefaultScreen extends StatefulWidget {
  const DefaultScreen({super.key});

  @override
  State<DefaultScreen> createState() => _DefaultScreenState();
}

class _DefaultScreenState extends State<DefaultScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) { 
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
            icon: Badge(child: Icon(Icons.video_call_rounded)),
            label: 'Video',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.info_outline),
            ),
            label: 'Info',
          ),
        ],
      ),
      body: <Widget>[
        FeedScreen(),
        VideoScreen(),
        InfoScreen(),

      ][currentPageIndex],
    );
  }
}
