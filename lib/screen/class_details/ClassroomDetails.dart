import 'package:class_room_chin/components/CustomScaffoldWithAppBar.dart';
import 'package:class_room_chin/constants/Colors.dart';
import 'package:class_room_chin/models/Classroom.dart';
import 'package:class_room_chin/screen/class_details/Persons.dart';
import 'package:class_room_chin/utils/Extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'Feeds.dart';

Classroom? chooseClass = null;

class ClassroomDetails extends StatefulWidget {
  const ClassroomDetails({Key? key}) : super(key: key);
  @override
  State<ClassroomDetails> createState() => _ClassroomDetailsState();
}

class _ClassroomDetailsState extends State<ClassroomDetails> {

  int _currentIndex = 0;
  final _pageController = PageController(initialPage: 0);
  final _pages = [const Feeds(), const Persons()];
  @override
  void dispose() {
    _pageController.dispose();
    chooseClass = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index)=>setState(() => _currentIndex = index),
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => _pageController.animateToPage(i, duration: const Duration(seconds: 1), curve: Curves.fastLinearToSlowEaseIn),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),

          // /// Likes
          // SalomonBottomBarItem(
          //   icon: Icon(Icons.favorite_border),
          //   title: Text("Likes"),
          // ),
          //
          // /// Search
          // SalomonBottomBarItem(
          //   icon: Icon(Icons.search),
          //   title: Text("Search"),
          // ),

          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),
        ],
      ),
    );
  }
}




