import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/config/json.dart';

String getSettingFastViewContent() {
  var map = getJsonMap();
  String res = "";
  String key;
  String value;
  for (var entry in map.entries) {
    try {
      key = getTranslation(entry.key);
      value = entry.value.toString();
    } on Exception catch (_) {
      key = getTranslation(entry.key);
      value = entry.value.toString();
    }
    res = "$res$key : $value\n";
  }
  return res;
}

class SettingFastViewer extends StatefulWidget {
  const SettingFastViewer({super.key});

  @override
  State<StatefulWidget> createState() {
    return SFVState();
  }
}

class SFVState extends State {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Text(
      getSettingFastViewContent(),
      maxLines: null,
    ));
  }
}
