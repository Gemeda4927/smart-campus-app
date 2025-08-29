import 'package:flutter/material.dart';
import 'package:mobile/app.dart';
import 'package:mobile/injector.dart';

void main()  async{
   WidgetsFlutterBinding.ensureInitialized();
  await initInjector(); 
  runApp(const MyApp());
}

