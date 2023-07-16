import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/pages/pages.dart';

class LoggingFastViewer extends StatefulWidget {
  const LoggingFastViewer({super.key});

  @override
  State<StatefulWidget> createState() {
    return LFVState();
  }
}

class LFVState extends State {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    enablePageRefresh = true;
    String con = "";
    File logf = File("rosa_Data/latest.log");
    if (logf.existsSync()) {
      con = logf.readAsStringSync();
    }
    return Card(
        child: SelectableText(
      con,
      maxLines: null,
    ));
  }
}
