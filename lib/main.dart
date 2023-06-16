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
            scaffoldBackgroundColor: Colors.white,
            accentColor: SystemTheme.accentColor.accent.toAccentColor(),
            iconTheme: const IconThemeData(size: 24)),
        darkTheme: FluentThemeData(
            scaffoldBackgroundColor: Colors.white,
            accentColor: SystemTheme.accentColor.accent.toAccentColor(),
            iconTheme: const IconThemeData(size: 24)),
        home: NavigationView(
            appBar: const NavigationAppBar(
                title: Text("ROSA - Setup the workspace")),
            pane: NavigationPane(displayMode: PaneDisplayMode.auto, items: [
              PaneItem(
                icon: const Icon(FluentIcons.home),
                title: const Text("Home"),
                body: const ScaffoldPage(
                  header: Text("HOME PAGE IS HERE"),
                ),
              )
            ])));
  }
}
