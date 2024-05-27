import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:yeni_kayan_ekran/isaretci_1/ana_page/textbox_page.dart';
import "package:yeni_kayan_ekran/isaretci_1/person_sign_up_pages/pages/login_or_register_page.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey.shade800,
        title: Text(
          "Düzenle: " + field,
          style: TextStyle(
            color: Colors.grey.shade100,
          ),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(
            color: Colors.grey.shade100,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w300,
          ),
          decoration: InputDecoration(
              hintText: "Yeni $field Gir",
              hintStyle: TextStyle(
                color: const Color.fromARGB(148, 245, 245, 245),
              )),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
              child: Text(
                'İptal',
                style: TextStyle(
                    color: Colors.grey.shade100,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w300),
              ),
              onPressed: () => Navigator.of(context).pop(context)),
          TextButton(
              child: Text(
                'Kaydet',
                style: TextStyle(
                    color: Colors.grey.shade100,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w300),
              ),
              onPressed: () => Navigator.of(context).pop(newValue)),
        ],
      ),
    );

    if (newValue.trim().length > 0) {
      await usersCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text(
            textAlign: TextAlign.center,
            "               Profil ",
            style: TextStyle(
              color: Colors.grey.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          backgroundColor: Colors.grey.shade100,
        ),
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUser.email!) // Ensure currentUser.email is valid
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  children: [
                    SizedBox(height: 80),
                    Icon(
                      Icons.manage_accounts_rounded,
                      size: 72,
                      color: Colors.grey.shade900,
                    ),
                    Text(
                      currentUser.email!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Poppins", fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        'Hakkımda',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    MyTextBox(
                      text: userData['Kullanıcı Adı'],
                      sectionName: 'Kullanıcı Adı',
                      onPressed: () => editField('Kullanıcı Adı'),
                    ),
                    MyTextBox(
                      text: userData['Biyografi'],
                      sectionName: 'Biyografi',
                      onPressed: () => editField('Biyografi'),
                    ),
                    SizedBox(height: 30),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginOrRegisterPage(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.logout_rounded,
                        color: Colors.grey.shade900,
                        size: 72,
                      ),
                    ),
                    Text(
                      'Çıkış Yap',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w300,
                          fontSize: 15),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Hata${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            }));
  }
}
