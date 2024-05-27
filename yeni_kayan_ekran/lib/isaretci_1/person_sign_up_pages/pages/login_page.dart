import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yeni_kayan_ekran/isaretci_1/ana_page/navigation_bar_control_page.dart';
import 'package:yeni_kayan_ekran/isaretci_1/person_sign_up_pages/components/my_textfield.dart';
import 'package:yeni_kayan_ekran/isaretci_1/person_sign_up_pages/components/square_tile.dart';
import 'package:yeni_kayan_ekran/isaretci_1/person_sign_up_pages/components/my_button.dart';


class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (!mounted) return; //kaldır çünkü login or register ı engelliuo

      Navigator.pop(context);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const NavigationBarControlPage()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 112, 3),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.grey.shade200,
                Colors.grey.shade200,
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  /* Image.asset(
                    "assets/group_person.png",
                  ),*/
                  const Icon(
                    Icons.account_circle_rounded,
                    size: 100,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Tekrar Hoş Geldin!',
                    style: TextStyle(
                        color: Colors.grey.shade900,
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 25),
                  MyTextField(
                    controller: emailController,
                    hintText: 'E-Posta',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Şifre',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Şifreni mi unuttun?',
                          style: TextStyle(
                              color: Colors.grey.shade900,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyButton(
                    //
                    text: "Giriş Yap",
                    onTap: signUserIn,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Veya giriş yap',
                            style: TextStyle(
                                color: Colors.grey.shade900,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                        
                        imagePath: 'images/google_icon.png'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Üye değil misiniz?',
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w300,
                          )),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Şimdi kaydolun !',
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
