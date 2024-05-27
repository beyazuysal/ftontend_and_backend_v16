import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class CallPage3 extends StatefulWidget {
  const CallPage3({super.key});

  @override
  State<CallPage3> createState() => _CallPage3State();
}

class _CallPage3State extends State<CallPage3> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool _muted = false;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: "4c2b71e4f37045b69723263d5cb60d89",
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("Local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left channel");
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

  // Toggle mute
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
              height: 150,
              child: _localUserJoined
                  ? AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: _engine,
                        canvas: const VideoCanvas(uid: 0),
                      ),
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
          _toolbar(),
        ],
      ),
    );
  }

  Widget _toolbar() {
    if (_remoteUid != null) {
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
    } else {
      return const SizedBox();
    }
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
        'Please wait for the remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
