import 'dart:convert';
import 'dart:io';

import 'package:rosa/config/i18n.dart';
import 'package:rosa/const.dart';
import 'package:rosa/pages/pages.dart';
import 'package:rosa/pages/widgets/setviewgen.dart';

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

Map getJsonMap() {
  File file = File(configPath);
  return jsonDecode(file.readAsStringSync());
}

void writeJsonValue(String key, dynamic value) {
  File file = File(configPath);
  Map jsonmap = jsonDecode(file.readAsStringSync());
  jsonmap[key] = value;
  file.writeAsStringSync(jsonEncode(jsonmap));
  SFVState state = fastviewKey.currentState! as SFVState;
  state.refresh();
}

Map initTranslation(Map initdata) {
  File file = File(getTranslatePath());
  if (file.existsSync()) {
    return jsonDecode(file.readAsStringSync());
  } else {
    file.writeAsStringSync(jsonEncode(initdata));
    return initdata;
  }
}

dynamic getTranslation(String key) {
  File file = File(getTranslatePath());
  var result = jsonDecode(file.readAsStringSync())[key];
  if (result == null) {
    return "$key->null";
  }
  return result;
}

Map initManifestMap(Map initdata) {
  File file = File(manifestPath);
  if (file.existsSync()) {
    return jsonDecode(file.readAsStringSync());
  } else {
    file.writeAsStringSync(jsonEncode(initdata));
    return initdata;
  }
}

dynamic getManifest(String key) {
  File file = File(manifestPath);
  return jsonDecode(file.readAsStringSync())[key];
}
