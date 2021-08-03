import 'package:hive_flutter/hive_flutter.dart';

class Session {
  static write(String key, String value) async {
    var box = await Hive.openBox('user');
    box.put(key, value);
    box.close();
  }

  static Future<String> read(String key) async {
    var box = await Hive.openBox('user');
    return box.get(key);
  }
}
