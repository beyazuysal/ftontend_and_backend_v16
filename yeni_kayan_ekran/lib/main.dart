import 'package:flutter/material.dart';
import 'package:yeni_kayan_ekran/isaretci_1/person_sign_up_pages/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yeni_kayan_ekran/isaretci_1/splash_screen.dart';

//githuba atmadan
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
