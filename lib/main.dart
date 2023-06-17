import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';

import 'package:rosa/routes/page_home.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FluentApp(
        theme: FluentThemeData(
            brightness: Brightness.light,
            accentColor: SystemTheme.accentColor.accent.toAccentColor(),
            iconTheme:
                IconThemeData(size: 24, color: SystemTheme.accentColor.accent)),
        darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: SystemTheme.accentColor.accent.toAccentColor(),
            iconTheme:
                IconThemeData(size: 24, color: SystemTheme.accentColor.accent)),
        home: NavigationView(
          paneBodyBuilder: (item, body) {
            return const ScaffoldPage(
              header: Text("hello"),
            );
          },
          appBar:
              const NavigationAppBar(title: Text("ROSA - Setup the workspace")),
          pane: NavigationPane(displayMode: PaneDisplayMode.auto, items: [
            PaneItem(
              icon: const Icon(FluentIcons.home),
              title: const Text("Home"),
              body: const SizedBox.shrink(),
            ),
            PaneItemHeader(header: const Text('Setup')),
            PaneItem(
              icon: const Icon(FluentIcons.toolbox),
              title: const Text("Toolkit"),
              body: const SizedBox.shrink(),
            )
          ], footerItems: [
            PaneItem(
                icon: const Icon(FluentIcons.settings),
                title: const Text("Settings"),
                body: const SizedBox.shrink()),
            PaneItem(
                icon: const Icon(FluentIcons.leave),
                title: const Text("Exit"),
                body: const SizedBox.shrink())
          ]),
        ));
  }
}
