import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/config/routes/route_name.dart';
import 'package:mobile/features/auth/login/presentation/bloc/login_bloc.dart';
import 'package:mobile/features/auth/signup/presentation/bloc/signup_bloc.dart';
import 'package:mobile/injector.dart';
import 'package:overlay_support/overlay_support.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<SignupBloc>()),
          BlocProvider(create: (_) => sl<LoginAuthBloc>()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Marsa',
          theme: ThemeData(primarySwatch: Colors.blue),
          routerConfig: appRouter,
        ),
      ),
    );
  }
}
