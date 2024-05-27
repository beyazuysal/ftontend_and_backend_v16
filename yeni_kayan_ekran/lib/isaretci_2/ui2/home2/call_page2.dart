import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yeni_kayan_ekran/isaretci_2/sign_translate_camera.dart';

class CallPage2 extends StatefulWidget {
  const CallPage2({super.key});

  @override
  State<CallPage2> createState() => _CallPage2State();
}

class _CallPage2State extends State<CallPage2> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  String detectedLetters = ''; // Algılanan harfleri saklamak için değişken
  final TextEditingController _textEditingController = TextEditingController();
  bool _muted = false;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: "4c2b71e4f37045b69723263d5cb60d89",
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token:
          "007eJxTYJh29d71PKv67QyXJzzY6Xm4N4Rz4YMzx/vM/1qaVzhP8f+kwGCSbJRkbphqkmZsbmBimmRmaW5kbGRmnGKanGRmkGJhKScTktYQyMhwYoo6KyMDBIL4bAwFRflZqakMDAAWiCDs",
      channelId: "projee",
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  void _onToggleMute() {
    setState(() {
      _muted = !_muted;
    });
    _engine.muteLocalAudioStream(_muted);
  }

  // End call
  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'İşaretçi Görüntülü arama',
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 300,
              child: Center(
                child: _localUserJoined
                    ? SignTranslateCameraPage(
                        onLettersDetected: (letters) {
                          setState(() {
                            detectedLetters = letters;
                            _textEditingController.text = letters;
                          });
                        },
                      ) // Kendi kamera widget'ınızı buraya ekleyin
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 20,
            right: 20,
            child: Container(
              color: Colors.black54,
              child: TextField(
                controller: _textEditingController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: '',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8),
                ),
              ),
            ),
          ),
          _toolbar(),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () => _onCallEnd(context),
              shape: const CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.redAccent,
              padding: const EdgeInsets.all(15.0),
              child: const Icon(
                Icons.call_end,
                color: Colors.white,
                size: 35.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid!),
          connection: const RtcConnection(channelId: "projee"),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
