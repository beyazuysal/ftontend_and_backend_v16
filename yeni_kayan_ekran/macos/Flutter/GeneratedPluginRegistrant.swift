//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import agora_rtc_engine
import cloud_firestore
import device_info_plus
import firebase_auth
import firebase_core
import iris_method_channel
import speech_to_text_macos

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AgoraRtcNgPlugin.register(with: registry.registrar(forPlugin: "AgoraRtcNgPlugin"))
  FLTFirebaseFirestorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseFirestorePlugin"))
  DeviceInfoPlusMacosPlugin.register(with: registry.registrar(forPlugin: "DeviceInfoPlusMacosPlugin"))
  FLTFirebaseAuthPlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseAuthPlugin"))
  FLTFirebaseCorePlugin.register(with: registry.registrar(forPlugin: "FLTFirebaseCorePlugin"))
  IrisMethodChannelPlugin.register(with: registry.registrar(forPlugin: "IrisMethodChannelPlugin"))
  SpeechToTextMacosPlugin.register(with: registry.registrar(forPlugin: "SpeechToTextMacosPlugin"))
}
