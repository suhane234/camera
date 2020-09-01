import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:camera/LoginScreen.dart';
import 'package:camera/SignUpScreen.dart';
import 'package:camera/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: Authenticate())],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue),
        home: SplashScreen(),
        routes: {
          SignUpScreen.routName: (ctx) => SignUpScreen(),
          LoginScreen.routName: (ctx) => LoginScreen()
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var PageTransitionType;
    return Container(
      child: AnimatedSplashScreen(
          duration: 3000,
          splash: Icons.camera_alt,
          nextScreen: SignUpScreen(),
          splashTransition: SplashTransition.slideTransition,
          backgroundColor: Colors.white60),
    );
  }
}
