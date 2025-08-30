import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/base_page.dart';
import 'package:mobile/config/routes/app_router.dart';
import 'package:mobile/features/auth/login/presentation/screen/login_screen.dart';
import 'package:mobile/features/auth/signup/presentation/screen/signup_screen.dart';
import 'package:mobile/features/features/profile/presentation/screen/profile_screen.dart';
import 'package:mobile/features/home/presentation/screen/home_screen.dart';
import 'package:mobile/features/courses/presentation/screen/courses_screen.dart';
import 'package:mobile/features/university/presentation/screen/universityDetailScreen.dart';
import 'package:mobile/features/university/presentation/screen/universityHomeScreen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteName.universities,
  debugLogDiagnostics: true,
  routes: [
    // Auth routes
    GoRoute(
      path: RouteName.login,
      name: RouteName.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: RouteName.signup,
      name: RouteName.signup,
      builder: (context, state) => SignupScreen(),
    ),
    // Shell route for bottom navigation
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => BasePage(child: child),
      routes: [
        GoRoute(
          path: RouteName.home,
          name: RouteName.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RouteName.courses,
          name: RouteName.courses,
          builder: (context, state) => const CoursesScreen(),
        ),
        GoRoute(
          path: RouteName.profile,
          name: RouteName.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
        // Universities routes
        GoRoute(
          path: RouteName.universities,
          name: RouteName.universities,
          builder: (context, state) => const UniversityHomeScreen(),
        ),
        GoRoute(
          path: RouteName.universityDetail,
          name: RouteName.universityDetail,
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return UniversityDetailScreen(universityId: id);
          },
        ),
      ],
    ),
  ],
);
