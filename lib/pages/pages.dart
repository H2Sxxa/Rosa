import 'package:fluent_ui/fluent_ui.dart';

import '../config/i18n.dart';
import 'markdown/pagegen.dart';

var pageHome = MarkdownFileBuilder(
  path: "${getI18nfullPath()}md/home.md",
  ispage: true,
);

var pageAbout = MarkdownFileBuilder(
  path: "${getI18nfullPath()}md/about.md",
  ispage: true,
);

var pageStickyBoard = ScaffoldPage.scrollable(children: [
  MarkdownFileBuilder(
      path: "${getI18nfullPath()}md/stickboard.md", ispage: false),
]);
