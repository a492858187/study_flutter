import 'package:flutter/cupertino.dart';
import 'package:study_flutter/demo/connect.dart';
import 'package:study_flutter/demo/device_map.dart';
import 'package:study_flutter/demo/image_picker.dart';
import 'package:study_flutter/demo/qrcode.dart';
import 'package:study_flutter/demo/shared_preferences.dart';
import 'package:study_flutter/demo/version.dart';
import 'package:study_flutter/demo/video_player.dart';
import 'refresh_indicator.dart';
import 'news_app.dart';

class Constants{
  static Map<String, WidgetBuilder> routes = {
    "/refresh_indicator" : (context) => RefreshIndicatorPage(),
    "/news_app" : (context) => NewsPage(),
    "/device_map" : (context) => DeviceMapPage(),
    "/image_picker" : (context) => ImagePickerPage(),
    "/video_player" : (context) => VideoPlayerPage(),
    "/connect" : (context) => ConnectPage(),
    "/shared_preferences" : (context) => SharedPreferencesPage(),
    "/qrcode" : (context) => QrCodePage(),
    "/version" : (context) => VersionPage(),
  };
}
