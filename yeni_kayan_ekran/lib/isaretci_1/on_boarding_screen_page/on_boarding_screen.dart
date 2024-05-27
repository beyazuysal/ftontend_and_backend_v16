import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yeni_kayan_ekran/isaretci_1/person_sign_up_pages/pages/login_or_register_page.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController = PageController();
  int currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          onPageChanged: (i) {
            setState(() {
              currentPageIndex = i;
            });
          },
          controller: _pageController,
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color.fromARGB(255, 238, 238, 238),
                    Color.fromARGB(255, 255, 255, 255),
                  ])),
              child: _page("assets/last_board1.png", "  Hoş Geldin!",
                  "  İyi vakit geçireceğine eminiz!"),
            ),
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color.fromARGB(255, 238, 238, 238),
                    Color.fromARGB(255, 255, 255, 255),
                  ])),
              child: _page("assets/last_board2.png", "  İletişim,",
                  "        günlük hayatımızın olmazsa olmazı..."),
            ),
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color.fromARGB(255, 238, 238, 238),
                    Color.fromARGB(255, 255, 255, 255),
                  ])),
              child: _page("assets/last_board3.png", "  Haydi başlayalım!", ""),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              onDotClicked: (index) {
                _pageController.jumpToPage(index);
              },
            ),
          ),
        ),
        if (currentPageIndex == 2)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(70),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginOrRegisterPage(),
                      ));
                },
                child: Text(
                  "Başla",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade900,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: const Color.fromARGB(255, 225, 225, 225),
                  onPrimary: Colors.grey.shade900,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ),
      ],
    ));
  }

  Widget _page(String imagePath, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background image
          Image.asset("assets/Rectangle 5.png"),
          // Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 225,
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Poppins"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
