import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poc_app/constants/route_constant.dart';
import 'package:poc_app/widgets/app_navbar.dart';
import 'package:poc_app/widgets/responsive.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.child,
    Key? key,
  }) : super(key: key);

  /// The widget to display in the body of the Scaffold.
  /// In this sample, it is a Navigator.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isDesktop(context)
          ? PreferredSize(
              preferredSize: Size(Responsive.screenSize(context).width, 70),
              child: AppNavBar(),
            )
          : null,
      body: child,
      bottomNavigationBar: Responsive.isMobile(context)
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              iconSize: 36.0,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.green[800],
              unselectedItemColor: Colors.grey,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
                BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Match"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book), label: "Bookmark"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "Profile"),
              ],
              currentIndex: _calculateSelectedIndex(context),
              onTap: (int idx) => _onItemTapped(idx, context),
            )
          : null,
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/chat')) {
      return 1;
    }
    if (location.startsWith('/match')) {
      return 2;
    }
    if (location.startsWith('/bookmark')) {
      return 3;
    }
    if (location.startsWith('/profile')) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).goNamed(RouteConstants.home);
        break;
      case 1:
        GoRouter.of(context).goNamed(RouteConstants.chat);
        break;
      case 2:
        GoRouter.of(context).pushNamed(RouteConstants.match);
        break;
      case 3:
        GoRouter.of(context).goNamed(RouteConstants.bookmark);
        break;
      case 4:
        GoRouter.of(context).goNamed(RouteConstants.profile);
        break;
    }
  }
}
