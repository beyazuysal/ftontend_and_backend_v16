import 'package:flutter/material.dart';
import 'package:yeni_kayan_ekran/isaretci_2/call_model.dart';
import 'package:yeni_kayan_ekran/isaretci_1/ana_page/navigation_bar_control_page.dart';
import 'package:yeni_kayan_ekran/isaretci_3/ui3/home3/home_page3.dart';
import 'package:yeni_kayan_ekran/isaretci_3/ui3/home3/home_page33.dart';
import 'package:yeni_kayan_ekran/isaretci_3/user_model.dart';

class LoginPage3 extends StatefulWidget {
  const LoginPage3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPage3State();
}

class LoginPage3State extends State<LoginPage3> {
  final TextEditingController userIdTextController =
      TextEditingController(text: 'ID');

  @override
  void initState() {
    super.initState();
    setup();
  }

  void setup() async {
    CallModel.getUniqueUserId().then((userId) async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Geri butonuna tıklandığında belirli bir sayfaya yönlendirme
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    NavigationBarControlPage(), // Yönlendirilecek sayfa
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/videocall_image.png",
                    height: 200,
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: userIdTextController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'ID ',
                    ),
                    onChanged: (value) => () {},
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () => signIn(),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          "ID oluştur",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage33()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Center(
                        child: Text(
                          "ID oluşturmadan devam et",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
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

  void signIn() {
    CallModel.getUniqueUserId().then((userId) {
      setState(() {
        userIdTextController.text = userId;
      });

      currentUser.id = userId;
      currentUser.name = 'user_$userId';

      // 3 saniye bekledikten sonra HomePage2'ye geçiş yap
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage3(userId: userIdTextController.text)),
        );
      });
    });
  }
}
