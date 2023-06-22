import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/config/json.dart';
import 'package:system_theme/system_theme.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:url_launcher/link.dart';

import 'package:rosa/markdown/pagegen.dart';
import 'config/i18n.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initJsonMap({
    "localization": "zh_cn",
    "fontfamily": "BoldHans",
    "title": "ROSA - Setup the dev environment"
  });
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
    MarkdownFileBuilder(
      path: "${getI18nfullPath()}md/home.md",
      ispage: true,
    ),
    const Text("Page 2"),
    const Text("Page 3"),
    const Text("Page 4"),
    ScaffoldPage.scrollable(
        //header: const PageHeader(title: Text('Button')),
        children: [
          MarkdownFileBuilder(
            path: "${getI18nfullPath()}md/license.md",
            ispage: false,
          ),
          Row(
            children: [
              Link(
                // from the url_launcher package
                uri: Uri.parse('https://github.com/H2Sxxa/Rosa'),
                builder: (_, open) {
                  return FilledButton(
                      onPressed: open, child: const Text("Github"));
                },
              ),
              const SizedBox(
                width: 50,
              ),
              Link(
                // from the url_launcher package
                uri: Uri.parse('https://h2sxxa.github.io'),
                builder: (_, open) {
                  return FilledButton(
                      onPressed: open, child: const Text("H2Sxxa's Blog"));
                },
              ),
              const SizedBox(
                width: 50,
              ),
              Link(
                // from the url_launcher package
                uri: Uri.parse('https://space.bilibili.com/393570351'),
                builder: (_, open) {
                  return FilledButton(
                      onPressed: open, child: const Text("BiliBili"));
                },
              )
            ],
          ),
        ])
  ];

  @override
  Widget build(BuildContext context) {
    return FluentApp(
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
                  title: const Text("Home"),
                  body: const SizedBox.shrink(),
                ),
                PaneItemHeader(header: const Text('Setup')),
                PaneItem(
                  icon: const Icon(FluentIcons.toolbox),
                  title: const Text("Toolkit"),
                  body: const SizedBox.shrink(),
                ),
                PaneItem(
                  icon: const Icon(FluentIcons.sticky_notes_outline_app_icon),
                  title: const Text("Sticky board"),
                  body: const SizedBox.shrink(),
                )
              ],
              footerItems: [
                PaneItem(
                  icon: const Icon(FluentIcons.settings),
                  title: const Text("Settings"),
                  body: const SizedBox.shrink(),
                ),
                PaneItem(
                    icon: const Icon(FluentIcons.accounts),
                    title: const Text("About"),
                    body: const SizedBox.shrink())
              ]),
        ));
  }
}
