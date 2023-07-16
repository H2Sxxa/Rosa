import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/config/json.dart';

String getSettingFastViewContent() {
  var map = getJsonMap();
  List<String> reslist = [];
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
    reslist.add("$key : $value");
  }
  return reslist.join("\n");
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
