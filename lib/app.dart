import 'package:flutter/material.dart';
import 'package:mobile/config/routes/route_name.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Marsa',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: appRouter,
    );
  }
}
