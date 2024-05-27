import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yeni_kayan_ekran/isaretci_1/person_sign_up_pages/components/my_textfield.dart';
import 'package:yeni_kayan_ekran/isaretci_1/person_sign_up_pages/components/square_tile.dart';
import 'package:yeni_kayan_ekran/isaretci_1/person_sign_up_pages/components/my_button.dart';

import 'package:yeni_kayan_ekran/isaretci_1/person_sign_up_pages/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
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

    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      showErrorMessage("Şifreler eşleşmiyor!");
      return;
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (!mounted) return; //kaldır çünkü login or register ı engelliuo

      FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'Kullanıcı Adı': emailController.text.split('@')[0],
        'Biyografi': 'Merhaba , ben İşaretçi kullanıyorum'
      });
      if (context.mounted) {
        Navigator.pop(context);
        showSuccessMessage("Başarıyla kayıt oldunuz!"); // Bu satırı ekledik
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      showErrorMessage(e.code);
    }
  }

  void showSuccessMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(
              126, 0, 255, 8), // Başarılı mesajlar genellikle yeşil renkte olur
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w300,
                  fontSize: 20),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(
                'Tamam',
                style: TextStyle(
                    color: Colors.grey.shade900,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w300,
                    fontSize: 15),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Dialog'u kapat
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage(
                            onTap: () {},
                          )),
                ); // LoginPage'e yönlendir
              },
            ),
          ],
        );
      },
    );
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(159, 255, 111, 0),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w300,
                  fontSize: 20),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                const SizedBox(height: 25),
                Icon(
                  Icons.account_circle_rounded,
                  size: 50,
                ),
                const SizedBox(height: 20),
                Text(
                  'Şimdi kaydol!',
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w300,
                  ),
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
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Doğrulama Şifresi',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyButton(
                  text: "Kaydol",
                  onTap: signUserUp,
                ),
                const SizedBox(height: 10),
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
                    SquareTile(imagePath: 'images/google_icon.png'),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hesabınız var mı?',
                        style: TextStyle(
                          color: Colors.grey.shade900,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w300,
                        )),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Şimdi giriş yapın !',
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
          )),
        ),
      ),
    );
  }
}
