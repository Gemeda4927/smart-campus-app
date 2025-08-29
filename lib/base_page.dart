import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/config/routes/app_router.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key, required this.child});
  final Widget child;

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home_filled),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.menu_book_outlined),
      activeIcon: Icon(Icons.menu_book),
      label: 'Courses',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bar_chart_outlined),
      activeIcon: Icon(Icons.bar_chart),
      label: 'Progress',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.verified_outlined),
      activeIcon: Icon(Icons.verified),
      label: 'Certificates',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outlined),
      activeIcon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();
    final currentIndex = _routeToIndex(currentRoute);

    // Saturate colors for selected and unselected icons
    final Color saturatedPrimary = HSLColor.fromColor(
      Theme.of(context).colorScheme.primary,
    ).withSaturation(1.0).toColor();

    final Color saturatedUnselected = HSLColor.fromColor(
      Colors.deepPurpleAccent,
    ).withSaturation(1.0).toColor();

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => context.go(_indexToRoute(index)),
            selectedItemColor: saturatedPrimary,
            unselectedItemColor: saturatedUnselected.withOpacity(1.0),
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            elevation: 10,
            backgroundColor: Theme.of(context).colorScheme.surface,
            items: navItems,
          ),
        ),
      ),
    );
  }

  int _routeToIndex(String route) {
    final routeMap = {
      RouteName.home: 0,
      RouteName.courses: 1,
      RouteName.progress: 2,
      RouteName.certificate: 3,
      RouteName.profile: 4,
    };
    return routeMap[route] ?? 0;
  }

  String _indexToRoute(int index) {
    final routeMap = {
      0: RouteName.home,
      1: RouteName.courses,
      2: RouteName.progress,
      3: RouteName.certificate,
      4: RouteName.profile,
    };
    return routeMap[index] ?? RouteName.home;
  }
}
