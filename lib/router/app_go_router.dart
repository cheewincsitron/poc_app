import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:poc_app/constants/route_constant.dart';
import 'package:poc_app/presentations/bloc/auth_bloc/auth_bloc.dart';
import 'package:poc_app/router/go_router__refresh_stream.dart';
import 'package:poc_app/screens/bookmark_screen.dart';
import 'package:poc_app/screens/chat_screen.dart';
import 'package:poc_app/screens/home_screen.dart';
import 'package:poc_app/screens/login_screen.dart';
import 'package:poc_app/screens/match_screen.dart';
import 'package:poc_app/screens/profile_screen.dart';
import 'package:poc_app/screens/reading_screen.dart';
import 'package:poc_app/screens/splash_screen.dart';
import 'package:poc_app/widgets/scafford_with_navbar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

GoRouter routes(AuthenticationBloc bloc) {
  return GoRouter(
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        name: RouteConstants.splash,
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      // GoRoute(
      //   name: RouteConstants.home,
      //   path: '/home',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const HomeScreen();
      //   },
      // ),

      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return ScaffoldWithNavBar(child: child);
          },
          routes: [
            GoRoute(
              name: RouteConstants.home,
              path: '/home',
              builder: (BuildContext context, GoRouterState state) {
                return const HomeScreen();
              },
            ),
            GoRoute(
              name: RouteConstants.chat,
              path: '/chat',
              builder: (BuildContext context, GoRouterState state) {
                return const ChatScreen();
              },
            ),
            GoRoute(
              name: RouteConstants.bookmark,
              path: '/bookmark',
              builder: (BuildContext context, GoRouterState state) {
                return const BookMarkScreen();
              },
            ),
            GoRoute(
              name: RouteConstants.profile,
              path: '/profile',
              builder: (BuildContext context, GoRouterState state) {
                return const ProfileScreen();
              },
            ),
          ]),
      // GoRoute(
      //   name: RouteConstants.main,
      //   path: '/main',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const MainScreen();
      //   },
      // ),
      // GoRoute(
      //   name: RouteConstants.home,
      //   path: '/home',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const HomeScreen();
      //   },
      // ),
      // GoRoute(
      //   name: RouteConstants.match,
      //   path: '/match',
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const MatchScreen();
      //   },
      // ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteConstants.match,
        path: '/match',
        builder: (BuildContext context, GoRouterState state) {
          return const MatchScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteConstants.login,
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        name: RouteConstants.reading,
        path: '/reading',
        builder: (BuildContext context, GoRouterState state) {
          return const ReadingScreen();
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      // if the user is not logged in, they need to login
      final bool loggedIn = bloc.state is AuthenticationAuthenticated;
      final bool loggingIn = state.subloc == '/login';
      // if (!loggedIn) {
      //   return '/login';
      // }

      // if the user is logged in but still on the login page, send them to
      // the home page
      if (loggedIn && loggingIn) {
        return '/home';
      }
      if (kIsWeb && state.subloc == '/') {
        return '/home';
      }

      // no need to redirect at all
      return null;
    },
    refreshListenable: GoRouterRefreshStream(bloc.stream),
  );
}
