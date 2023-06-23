import 'package:fluent_ui/fluent_ui.dart';

import '../../main.dart';

Future<bool> showConfirmDialog(String content) async {
  var context = navigatorKey.currentState!.context;
  var defres = false;
  var result = await showDialog(
      context: context,
      builder: (context) => ContentDialog(
            title: const Text("Confirm?"),
            content: Text(content),
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
  if (result == null) {
    return defres;
  } else {
    return result as bool;
  }
}

void showInfoBar(BuildContext context) {
  displayInfoBar(context, builder: (context, close) {
    return InfoBar(
      title: const Text('You can not do that :/'),
      content: const Text(
          'A proper warning message of why the user can not do that :/'),
      action: IconButton(
        icon: const Icon(FluentIcons.clear),
        onPressed: close,
      ),
      severity: InfoBarSeverity.warning,
    );
  });
}
