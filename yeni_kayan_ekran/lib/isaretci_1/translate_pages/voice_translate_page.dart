import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:yeni_kayan_ekran/isaretci_1/ana_page/navigation_bar_control_page.dart';

class VoiceTranslatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "                      Sesçi",
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
            )
          ],
        ),
        body: Container(
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
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(0, 0, 0, 0)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: AspectRatio(
                    aspectRatio: 9 / 16, // Kamera en-boy oranı
                    child: MyCamera(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const MyHomePage(),
            ],
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
  late CameraController _controller;
  bool _isCameraReady = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
    );
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
    );

    await _controller.initialize();

    if (mounted) {
      setState(() {
        _isCameraReady = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraReady) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CameraPreview(_controller),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String detectedText;
  late SpeechToText speechToText;
  late bool isListening;

  @override
  void initState() {
    super.initState();
    detectedText = "Kayıt için mikrofona tıklayınız";
    speechToText = SpeechToText();
    isListening = false;
    checkMicrophone();
  }

  void checkMicrophone() async {
    bool isAvailable = await speechToText.initialize();
    if (!isAvailable) {
      // Handle if microphone is not available
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 1),
        Row(
          children: [
            SizedBox(width: 18), // İkonun solunda boşluk
            GestureDetector(
              onTap: () async {
                if (!isListening) {
                  bool isAvailable = await speechToText.initialize();
                  if (isAvailable) {
                    setState(() {
                      isListening = true;
                    });

                    speechToText.listen(
                      listenFor: const Duration(seconds: 20),
                      onResult: (result) {
                        setState(() {
                          detectedText = result.recognizedWords;
                          isListening = false;
                        });
                      },
                    );
                  }
                } else {
                  setState(() {
                    isListening = false;
                    speechToText.stop();
                  });
                }
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  isListening ? Icons.record_voice_over : Icons.mic,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
            SizedBox(width: 1), // Icon ile TextField arasına boşluk eklendi
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 15.0),
                child: TextField(
                  readOnly: true,
                  style: const TextStyle(
                    fontSize: 15,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  controller: TextEditingController(text: detectedText),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
