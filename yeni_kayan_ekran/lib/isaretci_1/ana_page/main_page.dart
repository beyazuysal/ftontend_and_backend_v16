import 'package:flutter/material.dart';

import 'package:yeni_kayan_ekran/isaretci_1/translate_pages/sign_translate_pages.dart';
import 'package:yeni_kayan_ekran/isaretci_1/translate_pages/voice_translate_page.dart';
import 'package:yeni_kayan_ekran/isaretci_1/video_call_person_pages/video_call_person_pages.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          const SizedBox(height: 100),
          Text(
            "Ne yapmak istersin ?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontSize: 25,
              color: Colors.grey.shade900,
            ),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VoiceTranslatePage(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                height: 110,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.graphic_eq_rounded,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 60,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Ses Çevirme",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(200, 2, 255, 132),
                      Color.fromARGB(255, 1, 113, 238),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 168, 168, 168),
                      offset: Offset(-5.0, -5.0),
                      blurRadius: 15,
                      spreadRadius: 0.0,
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255),
                      offset: Offset(5.0, 5.0),
                      blurRadius: 15,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignTranslatePage(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                height: 110,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.sign_language_rounded,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 60,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "İşaret Dili Çevirme",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(200, 254, 234, 78),
                      Color.fromARGB(255, 237, 67, 121),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 168, 168, 168),
                      offset: Offset(-5.0, -5.0),
                      blurRadius: 15,
                      spreadRadius: 0.0,
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255),
                      offset: Offset(5.0, 5.0),
                      blurRadius: 15,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoCallPersonPage(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                height: 110,
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.video_call_rounded,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 60,
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Görüntülü Arama",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 249, 179, 75),
                      Color.fromARGB(255, 201, 45, 214),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 168, 168, 168),
                      offset: Offset(-5.0, -5.0),
                      blurRadius: 15,
                      spreadRadius: 0.0,
                    ),
                    BoxShadow(
                      color: Color.fromARGB(255, 255, 255, 255),
                      offset: Offset(5.0, 5.0),
                      blurRadius: 15,
                      spreadRadius: 0.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
