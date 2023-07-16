import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/config/json.dart';
import 'package:rosa/main.dart';

Future<Object?> showConDialog(Widget? content, String title) async {
  var context = navigatorKey.currentState!.context;
  return await showDialog(
      context: context,
      builder: (context) => ContentDialog(
            title: Text(title),
            content: content,
            actions: [
              Button(
                child: Text(getTranslation("ok")),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              FilledButton(
                child: Text(getTranslation("cancel")),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          ));
}

Future<bool> showConfirmDialog(String content) async {
  var defres = false;
  var result = await showConDialog(Text(content), getTranslation("confirm"));
  if (result == null) {
    return defres;
  } else {
    return result as bool;
  }
}

Future<void> showInfoBar(String title, String content, [int? level]) async {
  late InfoBarSeverity severity;
  switch (level) {
    case 0:
      severity = InfoBarSeverity.success;
      break;
    case 1:
      severity = InfoBarSeverity.info;
      break;
    case 2:
      severity = InfoBarSeverity.warning;
      break;
    case 3:
      severity = InfoBarSeverity.error;
      break;
    default:
      severity = InfoBarSeverity.info;
      break;
  }
  
  displayInfoBar(paneKey.currentState!.context, builder: (context, close) {
    return InfoBar(
      title: Text(title),
      content: Text(content),
      action: IconButton(
        icon: const Icon(FluentIcons.clear),
        onPressed: close,
      ),
      severity: severity,
    );
  });
}
