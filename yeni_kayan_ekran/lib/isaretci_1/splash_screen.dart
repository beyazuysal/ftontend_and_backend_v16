import 'package:flutter/material.dart';
import 'package:yeni_kayan_ekran/isaretci_1/on_boarding_screen_page/on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoardingScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: Center(
        child: Column(
          children: [
            Expanded(child: _getLogo()),
            /*const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _getLogo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/son_splash_2.png",
          height: 225,
          width: 225,
        )
      ],
    );
  }
}