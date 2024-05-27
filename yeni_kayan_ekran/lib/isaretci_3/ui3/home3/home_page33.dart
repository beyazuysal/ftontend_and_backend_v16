import 'package:flutter/material.dart';

import 'package:yeni_kayan_ekran/isaretci_3/ui3/home3/call_page3.dart';
import 'package:yeni_kayan_ekran/isaretci_3/ui3/login_page3.dart';

class HomePage33 extends StatefulWidget {
  const HomePage33({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageVCState();
}

class HomePageVCState extends State<HomePage33> {
  /// Users who use the same callId can in the same call.

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
         backgroundColor: Colors.grey.shade200,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Geri butonuna tıklandığında belirli bir sayfaya yönlendirme
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginPage3(), // Yönlendirilecek sayfa
                ),
              );
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 50),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/hello_image.png",
                      height: 220,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Katılmak istediğiniz kanalın ID numarasını lütfen giriniz!',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white)),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'ID',
                    ),
                    onChanged: (value) => () {},
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () => onTap(),
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "Katıl",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CallPage3()));
  }
}
