import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  DeviceInfo({
    this.deviceId = '',
    this.deviceName = '',
    this.deviceVersion = '',
    this.modelName = '',
  });
  String? deviceId;
  String? deviceName;
  String? deviceVersion;
  String? modelName;

  Map<String, dynamic> toJson() => {
        'device_id': deviceId,
        'device_name': deviceName,
        'device_version': deviceVersion,
        'modelName': modelName,
      };

  static Future<DeviceInfo> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final DeviceInfo result = DeviceInfo();
    if (Platform.isIOS) {
      final IosDeviceInfo info = await deviceInfo.iosInfo;
      result.deviceId = info.identifierForVendor;
      result.deviceName = info.name;
      result.deviceVersion = info.systemVersion;
      result.modelName = info.utsname.machine;
    }

    if (Platform.isAndroid) {
      final AndroidDeviceInfo info = await deviceInfo.androidInfo;

      result.deviceId = info.id;
      result.deviceName = info.model;
      result.modelName = info.device;
      result.deviceVersion = info.version.sdkInt.toString();
    }
    return result;
  }
}
