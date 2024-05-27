import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';

class CallModel {
  static String appId = "4c2b71e4f37045b69723263d5cb60d89";
  static String appToken =
      "007eJxTYJh29d71PKv67QyXJzzY6Xm4N4Rz4YMzx/vM/1qaVzhP8f+kwGCSbJRkbphqkmZsbmBimmRmaW5kbGRmnGKanGRmkGJhKScTktYQyMhwYoo6KyMDBIL4bAwFRflZqakMDAAWiCDs";

  static Future<String> getUniqueUserId() async {
    String? deviceId;
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id; // unique ID on Android
    }

    // Eğer deviceId mevcut değilse veya uzunluğu 4'ten azsa, platforma özel ekleme yap
    if (deviceId != null && deviceId.length < 4) {
      if (Platform.isAndroid) {
        deviceId += '_android';
      } else if (Platform.isIOS) {
        deviceId += '_ios___';
      }
    }
    if (Platform.isAndroid) {
      deviceId ??= 'flutter_user_id_android';
    } else if (Platform.isIOS) {
      deviceId ??= 'flutter_user_id_ios';
    }

    // Rastgele bir sayı oluştur
    final random = Random();
    final randomInt =
        random.nextInt(100000); // 0 ile 99999 arasında rastgele bir sayı

    // Cihaz ID'sine rastgele sayıyı ekle
    deviceId = '$deviceId$randomInt';

    // Hash'leyerek benzersiz bir kullanıcı ID'si oluştur
    final userId = md5
        .convert(utf8.encode(deviceId))
        .toString()
        .replaceAll(RegExp(r'[^0-9]'), '');

    return userId.substring(userId.length - 4); // Son 6 karakteri al
  }
}
