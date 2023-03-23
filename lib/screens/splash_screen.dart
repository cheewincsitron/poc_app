import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/route_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;
  bool didMouth = false;

  @override
  void initState() {
    super.initState();

    didMount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedOpacity(
      duration: const Duration(seconds: 1),
      opacity: !animate ? 0 : 1,
      child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/images/splash_page_anime.gif"),
              fit: BoxFit.cover,
            ),
          ),
          child: null),
    ));
  }

  Future didMount() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      animate = true;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    setState(() {
      didMouth = true;
    });

    if (!mounted) return;
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => const MainScreen()));
    // Navigator.pushReplacementNamed(context, '/main');
    // context.goNamed(RouteConstants.main);
    context.goNamed(RouteConstants.home);
  }
}
