import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yeni_kayan_ekran/isaretci_1/person_sign_up_pages/pages/home_page.dart';
import 'package:yeni_kayan_ekran/isaretci_1/person_sign_up_pages/pages/login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage(); 
            } else {
              return LoginOrRegisterPage();
            
            }
          }),
    );
  }
}
