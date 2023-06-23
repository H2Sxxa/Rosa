import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/pages/widgets/prompts.dart';

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

var _uploadtext = '';
var pageStickyBoard = ScaffoldPage.scrollable(children: [
  MarkdownFileBuilder(
      path: "${getI18nfullPath()}md/stickboard.md", ispage: false),
  const SizedBox(
    height: 20,
  ),
  Card(
      child: Wrap(
    children: [
      const SizedBox(
        height: 40,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilledButton(
              child: const Text("Upload Text"),
              onPressed: () async {
                debugPrint(_uploadtext);
                var result = await showConfirmDialog(
                    "Notice not to upload too frequent");
                if (result) {
                  debugPrint("true");
                } else {
                  debugPrint("false");
                }
              }),
          FilledButton(child: const Text("Upload File"), onPressed: () {})
        ],
      ),
      TextBox(
        maxLines: null,
        onChanged: (value) {
          _uploadtext = value;
        },
      ),
    ],
  )),
]);
