abstract class AppVersionService {
  String get version;

  String get buildNumber;

  String get fullVersionName => 'v$version+$buildNumber';

  String get platform;
}
