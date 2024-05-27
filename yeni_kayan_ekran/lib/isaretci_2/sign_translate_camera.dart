import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class SignTranslateCameraPage extends StatefulWidget {
  final Function(String) onLettersDetected; // Callback fonksiyon
  SignTranslateCameraPage({Key? key, required this.onLettersDetected})
      : super(key: key);

  @override
  _SignTranslateCameraPageState createState() =>
      _SignTranslateCameraPageState();
}

class _SignTranslateCameraPageState extends State<SignTranslateCameraPage> {
  CameraController? _controller;
  var detectedLetters = '';
  bool _isCameraInitialized = false;
  bool _isTakingPicture = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    // Kameraları alın
    final cameras = await availableCameras();

    // Ön kamerayı bulun
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    // Kamera denetleyicisini oluşturun
    _controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
    );

    // Denetleyiciyi başlatın
    await _controller!.initialize();

    // Kamera başarılı bir şekilde başlatıldıysa
    if (_controller!.value.isInitialized) {
      setState(() {
        _isCameraInitialized = true;
      });

      // Resim çekme ve gönderme işlemlerini başlatın
      takeAndSendPicture();
      _timer = Timer.periodic(Duration(seconds: 3), (timer) {
        if (!_isTakingPicture) {
          takeAndSendPicture();
        }
      });
    }
  }

  Future<void> takeAndSendPicture() async {
    setState(() {
      _isTakingPicture = true;
    });
    final image = await _controller!.takePicture();
    final file = File(image.path);
    await sendImage(file);
    setState(() {
      _isTakingPicture = false;
    });
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
        String newLetters = resultList['detected_letters'].join('');

        setState(() {
          detectedLetters += newLetters;
        });

        widget.onLettersDetected(detectedLetters);
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isCameraInitialized
        ? Stack(
            children: [
              CameraPreview(_controller!),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        detectedLetters,
                        style: TextStyle(
                          color: Color.fromARGB(0, 0, 0, 0),
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Center(child: CircularProgressIndicator());
  }
}
