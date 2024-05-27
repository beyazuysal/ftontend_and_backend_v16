import 'dart:async'; //
//import 'package:auto_scroll_text/auto_scroll_text.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:core';

import 'package:yeni_kayan_ekran/isaretci_1/ana_page/navigation_bar_control_page.dart';

class SignTranslatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text(
              "                    İşaretçi",
              style: TextStyle(
                fontSize: 25,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: Colors.grey.shade200,
            actions: <Widget>[
              IconButton(
                icon: Image.asset(
                  'assets/backspace_button.png',
                  width: 20,
                  height: 20,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavigationBarControlPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          body: Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(0, 0, 0, 0)),
              borderRadius: BorderRadius.circular(20),
            ),
            child: MyCamera(),
          ),
        ),
      ),
    );
  }
}

class MyCamera extends StatefulWidget {
  @override
  _MyCameraState createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {
  CameraController? _controller;
  var detectedLetters = '';

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );
    await _controller!.initialize();
    if (_controller!.value.isInitialized) {
      takePicture();
    }
  }

  Future<void> takeAndSendPicture() async {
    final image = await _controller!.takePicture();
    final file = File(image.path);
    await sendImage(file);
  }

  Future<void> repeatTakePicture() async {
    const threeSec = Duration(seconds: 3);

    Timer.periodic(threeSec, (timer) async {
      await takeAndSendPicture();
    });
  }

  Future<void> takePicture() async {
    await takeAndSendPicture();
    repeatTakePicture();
  }

  Future<void> sendImage(File image) async {
    final uri = Uri.parse('http://192.168.0.12:5000/process_letters');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var resultList = jsonDecode(data);

      if (resultList['detected_letters'] != null &&
          resultList['detected_letters'].isNotEmpty) {
        setState(() {
          detectedLetters = resultList['detected_letters'].join('');
        });
      }
    }
  }

  void deleteLetter() {
    setState(() {
      if (detectedLetters.isNotEmpty) {
        detectedLetters =
            detectedLetters.substring(0, detectedLetters.length - 1);
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        margin: EdgeInsets.all(1),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(0, 0, 0, 0)),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _controller != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CameraPreview(_controller!),
                      )
                    : Container(),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade900,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.backspace_rounded,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            deleteLetter();
                          },
                        ),
                      ),
                      controller: TextEditingController(text: detectedLetters),
                    ),
                  ),
                  SizedBox(width: 10),

                  //Harf kamerasına geçme butonu
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.change_circle_rounded,
                        color: Colors.black,
                        size: 45,
                      ),
                      onPressed: () {
                        buttonPressed();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buttonPressed() async {
    // API isteği gönderme işlemleri burada yapılacak
    final uri = Uri.parse('http://192.168.0.13:5000/button_pressed');
    var response = await http.post(uri);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print('Model switched: ${responseData['model_switched']}');
    } else {
      print('Failed to switch model');
    }
  }
}
