import 'package:flutter/material.dart';
import 'package:yeni_kayan_ekran/isaretci_2/ui2/login_page2.dart';
import 'package:yeni_kayan_ekran/isaretci_3/ui3/login_page3.dart';

class VideoCallPersonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
      ),
      body: Column(
        children: [
          const SizedBox(height: 120),
          Text(
            "Kullanıcı durumuna göre seçim yap!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontSize: 25,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 30),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage2(), //true
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
                    SizedBox(width: 60),
                    Text(
                      "İşaret Dili Biliyorum",
                      textAlign: TextAlign.center,
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
                      Color.fromARGB(255, 246, 162, 38),
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
          SizedBox(height: 20),
          MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage3(), //false
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
                    SizedBox(width: 55),
                    Text(
                      "İşaret Dili Bilmiyorum",
                      textAlign: TextAlign.center,
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
                      Color.fromARGB(255, 201, 45, 214),
                      Color.fromARGB(255, 246, 162, 38),
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
