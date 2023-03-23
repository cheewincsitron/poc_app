import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poc_app/constants/route_constant.dart';
import 'package:poc_app/screens/bookmark_screen.dart';
import 'package:poc_app/screens/chat_screen.dart';
import 'package:poc_app/screens/home_screen.dart';
import 'package:poc_app/screens/match_screen.dart';
import 'package:poc_app/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> screens = <Widget>[
    const HomeScreen(),
    ChatScreen(),
    MatchScreen(),
    BookMarkScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: screens),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        iconSize: 36.0,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Match"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Bookmark"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  void _onItemTapped(int value) {
    if (value == 2) {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => MatchScreen()));
      // Navigator.pushNamed(context, '/match');
      context.pushNamed(RouteConstants.match);
    } else {
      setState(() {
        _currentIndex = value;
      });
    }
  }
}
