import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/config/json.dart';
import 'package:rosa/pages/pages.dart';
import 'package:system_theme/system_theme.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  initJsonMap({
    "localization": "zh_cn",
    "fontfamily": "BoldHans",
    "title": "ROSA - Setup the dev environment"
  });
  initTranslation({
    "home": "主页",
    "about": "关于",
    "settings": "设置",
    "sticky": "粘贴板",
    "tookit": "工具箱",
    "doc": "文档"
  });
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _pageindex = 0;

  final pages = [
    pageHome,
    const Text("Page 1"),
    pageStickyBoard,
    const Text("Page 2"),
    pageAbout
  ];

  @override
  Widget build(BuildContext context) {
    return FluentApp(
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
                  icon: const Icon(FluentIcons.sticky_notes_outline_app_icon),
                  title: Text(getTranslation("sticky")),
                  body: const SizedBox.shrink(),
                ),
                PaneItemHeader(header: Text(getTranslation("doc")))
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
                    body: const SizedBox.shrink())
              ]),
        ));
  }
}
