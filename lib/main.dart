import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/config/init.dart';
import 'package:rosa/config/json.dart';
import 'package:rosa/const.dart';
import 'package:rosa/pages/pages.dart';
import 'package:system_theme/system_theme.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() async {
  systemFontFamilies = await initFontFamilies();
  initConfig();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
  doWhenWindowReady(() {
    final win = appWindow;
    win.title = getJsonValue("title");
    win.alignment = Alignment.center;
    win.minSize = const Size(600, 450);
    win.show();
  });
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
late State<MyApp> globalState;
void refreshState() {
  // ignore: invalid_use_of_protected_member
  globalState.setState(() {});
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _pageindex = 0;

  _MyAppState() {
    globalState = this;
  }

  final pages = [
    pageHome,
    pageProxy,
    pagePastebin,
    pageDownload,
    pageDoc,
    pageSettings,
    pageAbout
  ];
  @override
  Widget build(BuildContext context) {
    ThemeMode thememode;
    switch (getJsonValue("thememode")) {
      case -1:
        thememode = ThemeMode.dark;
        break;
      case 1:
        thememode = ThemeMode.light;
        break;
      default:
        thememode = ThemeMode.system;
        break;
    }

    return FluentApp(
        themeMode: thememode,
        navigatorKey: navigatorKey,
        theme: FluentThemeData(
            fontFamily: getJsonValue("fontfamily"),
            brightness: Brightness.light,
            accentColor: SystemTheme.accentColor.accent.toAccentColor(),
            iconTheme:
                IconThemeData(size: 24, color: SystemTheme.accentColor.accent)),
        darkTheme: FluentThemeData(
            fontFamily: getJsonValue("fontfamily"),
            brightness: Brightness.dark,
            accentColor: SystemTheme.accentColor.accent.toAccentColor(),
            iconTheme:
                IconThemeData(size: 24, color: SystemTheme.accentColor.accent)),
        home: NavigationView(
          paneBodyBuilder: (item, body) => IndexedStack(
            index: _pageindex,
            children: pages,
          ),
          pane: NavigationPane(
              displayMode: PaneDisplayMode.auto,
              selected: _pageindex,
              onChanged: (i) => setState(() => _pageindex = i),
              items: [
                PaneItem(
                  icon: const Icon(FluentIcons.home),
                  title: Text(getTranslation("home")),
                  body: const SizedBox.shrink(),
                ),
                PaneItemHeader(header: Text(getTranslation("tookit"))),
                PaneItem(
                  icon: const Icon(FluentIcons.toolbox),
                  title: const Text("Proxifier & Shadowsocks"),
                  body: const SizedBox.shrink(),
                ),
                PaneItem(
                  icon: const Icon(FluentIcons.paste),
                  title: Text(getTranslation("pastebin")),
                  body: const SizedBox.shrink(),
                ),
                PaneItem(
                    title: Text(getTranslation("download")),
                    icon: const Icon(FluentIcons.download),
                    body: const SizedBox.shrink()),
                PaneItem(
                    icon: const Icon(FluentIcons.book_answers),
                    title: Text(getTranslation("doc")),
                    body: const SizedBox.shrink())
              ],
              footerItems: [
                PaneItem(
                  icon: const Icon(FluentIcons.settings),
                  title: Text(getTranslation("settings")),
                  body: const SizedBox.shrink(),
                ),
                PaneItem(
                    icon: const Icon(FluentIcons.accounts),
                    title: Text(getTranslation("about")),
                    body: const SizedBox.shrink()),
              ]),
        ));
  }
}
