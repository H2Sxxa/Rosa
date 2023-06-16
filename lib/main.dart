import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';

void main() {
  runApp(const MyApp());
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
          appBar:
              const NavigationAppBar(title: Text("ROSA - Setup the workspace")),
          pane: NavigationPane(displayMode: PaneDisplayMode.auto, items: [
            PaneItem(
              icon: const Icon(FluentIcons.home),
              title: const Text("Home"),
              body: const ScaffoldPage(
                header: Text("HOME PAGE IS HERE"),
              ),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.toolbox),
              title: const Text("TOOKIT"),
              body: const ScaffoldPage(header: Text("TOOKIT PAGE IS HERE")),
            ),
          ]),
        ));
  }
}
