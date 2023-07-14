import 'package:flutter/material.dart';
import 'package:mobile_uas/config/provider.dart';
import 'package:mobile_uas/pages/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainProvider()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'InriaSans',
          textTheme: const TextTheme(
            titleMedium: TextStyle(
              color: Colors.white
            ),
            titleLarge: TextStyle(
              color: Colors.white
            ),
            titleSmall: TextStyle(
              color: Colors.white
            ),
            bodyLarge: TextStyle(
              color: Colors.white
            ),
            bodyMedium: TextStyle(
              color: Colors.white
            ),
            bodySmall: TextStyle(
              color: Colors.white
            ),
          ),
          radioTheme: RadioThemeData(
            fillColor: MaterialStateColor.resolveWith((states) => Colors.white)
          )
        ),
        home: const HomePage(),
      ),
    );
  }
}