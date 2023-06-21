import 'dart:convert';
import 'dart:io';

import 'package:rosa/const.dart';

Map initJsonMap(Map initdata) {
  File file = File(configPath);
  if (file.existsSync()) {
    return jsonDecode(file.readAsStringSync());
  } else {
    file.writeAsStringSync(jsonEncode(initdata));
    return initdata;
  }
}

dynamic getJsonValue(String key) {
  File file = File(configPath);
  return jsonDecode(file.readAsStringSync())[key];
}
