import 'package:rosa/const.dart';
import 'json.dart';

String getI18nfullPath() {
  return "${localizationPath + getJsonValue("localization")}/";
}
