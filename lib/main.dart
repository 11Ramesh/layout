import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lay_out_index/variable/color.dart';
import 'package:lay_out_index/screen/home.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatelessWidget {
  SplashColor colorss = SplashColor();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Center(
      child: AnimatedSplashScreen(
        backgroundColor: colorss.background,
        splash: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              child: Column(
                children: [
                  screenwidth < 520
                      ? Image.asset('assets/image/logo.png')
                      : Image.asset('assets/image/logo@2x.png'),
                  Text(
                    "LAYOUTindex Demo",
                    style: TextStyle(
                        fontSize: screenwidth * 0.06, color: colorss.text),
                  )
                ],
              ),
            );
          },
        ),
        nextScreen: Home(),
        splashIconSize: 250,
        duration: 500,
      ),
    );
  }
}
