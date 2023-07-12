import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/const.dart';
import 'json.dart';

String getI18nfullPath() {
  return "${localizationPath + getJsonValue("localization")}/";
}

String getTranslatePath() {
  return "${localizationPath + getJsonValue("localization")}/translation.json";
}

Image getLocalImage(String imagename) {
  return Image.file(File("${getI18nfullPath()}image/$imagename"));
}
