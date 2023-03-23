import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poc_app/constants/route_constant.dart';
import 'package:sizer/sizer.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 2.h, bottom: 2.h),
      // color: Colors.white,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "AppBar",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildMenuItem(
                text: "Home",
                route: RouteConstants.home,
              ),
              const SizedBox(width: 8),
              _buildMenuItem(
                text: "Chat",
                route: RouteConstants.chat,
              ),
              const SizedBox(width: 8),
              _buildMenuItem(
                text: "Match",
                route: RouteConstants.match,
              ),
              const SizedBox(width: 8),
              _buildMenuItem(
                text: "Bookmark",
                route: RouteConstants.bookmark,
              ),
              const SizedBox(width: 8),
              _buildMenuItem(
                text: "Profile",
                route: RouteConstants.profile,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({required String text, required String route}) {
    return Builder(builder: (context) {
      return TextButton(
        onPressed: () {
          context.goNamed(route);
        },
        style: TextButton.styleFrom().copyWith(
          animationDuration: Duration.zero,
          textStyle: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.hovered)) {
                return const TextStyle(color: Colors.yellow);
              }
              return const TextStyle(color: Colors.yellow);
            },
          ),
          // textStyle: MaterialStateProperty.resolveWith(
          //   (states) {
          //     if (states.contains(MaterialState.hovered)) {
          //       return TextStyle(
          //         fontSize: 4.sp,
          //       );
          //     }
          //     return TextStyle(
          //       fontSize: 4.sp,
          //     );
          //   },
          // ),
          // foregroundColor: MaterialStateProperty.resolveWith(
          //   (states) {
          //     if (states.contains(MaterialState.hovered)) {
          //       return Colors.blue;
          //     }
          //     return Colors.blue[700];
          //   },
          // ),
        ),
        child: Text(text),
      );
    });
  }
}
