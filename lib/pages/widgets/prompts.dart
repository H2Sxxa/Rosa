import 'package:fluent_ui/fluent_ui.dart';

import '../../main.dart';

Future<Object?> showConDialog(Widget? content, String title) async {
  var context = navigatorKey.currentState!.context;
  return await showDialog(
      context: context,
      builder: (context) => ContentDialog(
            title: Text(title),
            content: content,
            actions: [
              Button(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
              FilledButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
            ],
          ));
}

Future<bool> showConfirmDialog(String content) async {
  var defres = false;
  var result = await showConDialog(Text(content), "Confirm?");
  if (result == null) {
    return defres;
  } else {
    return result as bool;
  }
}
