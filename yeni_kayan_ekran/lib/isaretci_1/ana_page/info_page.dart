import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          '   İşaretçi Hakkında',
          style: TextStyle(
            color: Colors.grey.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'İşaretçi uygulaması, derin öğrenme algoritmaları kullanarak işaret dilini tanıyıp yazıya dönüştürerek iletişim engellerini aşmayı hedefliyor. Geliştirdiğimiz model, işaret dili harflerini ve kelimelerini yazılı metne çevirir ve konuşmaları alt yazıya dönüştürür. Kullanıcı dostu arayüzümüz, işitme engelli bireylerin aktif katılımını sağlar. Bu sayede, iletişim güçlenir, toplumsal katılım artar ve işitme engelli bireylerin hayatı kolaylaşır.',
            style: TextStyle(
              fontSize: 17,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              color: Colors.grey.shade800,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
