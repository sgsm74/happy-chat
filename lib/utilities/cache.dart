import 'package:hive_flutter/hive_flutter.dart';

class Cache {
  static put(String boxName, String key, String value) async {
    var box = await Hive.openBox(boxName);
    box.put(key, value);
  }

  static get(String boxName, String key) async {
    var box = await Hive.openBox(boxName);
    return box.get(key);
  }
}
