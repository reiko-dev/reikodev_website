import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reikodev_website/app/index.dart';

class AppVersionServiceImplementation extends AppVersionService {
  AppVersionServiceImplementation._();

  static PackageInfo? _instance;

  static Future<AppVersionService> instance() async {
    _instance = await PackageInfo.fromPlatform();

    return AppVersionServiceImplementation._();
  }

  @override
  String get version => _instance!.version;

  @override
  String get buildNumber => _instance!.buildNumber;

  @override
  String get fullVersionName => 'v$version+$buildNumber';

  @override
  String get platform {
    if (GetPlatform.isWeb) return 'web';

    if (GetPlatform.isAndroid) return 'android';

    if (GetPlatform.isIOS) return 'ios';

    return 'unknown';
  }
}
