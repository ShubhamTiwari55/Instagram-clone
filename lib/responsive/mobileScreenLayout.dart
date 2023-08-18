import 'package:flutter/material.dart';
import 'package:insta_clone/utils/globalVariables.dart';

import '../screen/addPostScreen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  late PageController pageController;
  int _page = 0;
  void navigationTap(int page){
    pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),  //changing screen like page view disabled
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(
            Icons.home, color: _page ==0?Colors.white:Colors.grey,)
              , label: '',
          backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(
              Icons.search, color: _page ==1?Colors.white:Colors.grey), label: '',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(icon: Icon(
              Icons.add_circle, color: _page ==2?Colors.white:Colors.grey), label: '',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(
              Icons.favorite, color: _page ==3?Colors.white:Colors.grey), label: '',
              backgroundColor: Colors.white),
          BottomNavigationBarItem(icon: Icon(
              Icons.person, color: _page ==4?Colors.white:Colors.grey), label: '',
              backgroundColor: Colors.white),
        ],
        onTap: navigationTap,
      ),
    );
  }
}
