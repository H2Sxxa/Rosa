import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/client/post.dart';
import 'package:rosa/config/json.dart';
import 'package:rosa/pages/widgets/prompts.dart';
import 'package:rosa/pages/widgets/selector.dart';

import '../config/i18n.dart';
import 'markdown/pagegen.dart';

var pageHome = MarkdownFileBuilder(
  path: "${getI18nfullPath()}md/home.md",
  ispage: true,
);

var pageProxy = ScaffoldPage.scrollable(children: [
  MarkdownFileBuilder(path: "${getI18nfullPath()}md/proxy.md", ispage: false),
  TreeView(
      selectionMode: TreeViewSelectionMode.multiple,
      items: [TreeViewItem(content: const Text("hello"), value: "hello")]),
  FilledButton(child: const Text("Run it!"), onPressed: () {})
]);

var pageDownload = ScaffoldPage.scrollable(children: [
  MarkdownFileBuilder(
      path: "${getI18nfullPath()}md/download/part0.md", ispage: false),
]);

var pageAbout = MarkdownFileBuilder(
  path: "${getI18nfullPath()}md/about.md",
  ispage: true,
);

var docHTSetup = MarkdownFileBuilder(
  path: "${getI18nfullPath()}md/htsetup.md",
  ispage: true,
);
var _uploadtext = '';
var pagePastebin = ScaffoldPage.scrollable(children: [
  MarkdownFileBuilder(
      path: "${getI18nfullPath()}md/pastebin.md", ispage: false),
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
              child: Text(getTranslation("upload_text")),
              onPressed: () async {
                var result = await showConfirmDialog(
                    "Notice not to upload too frequent");
                if (result) {
                  String feedback;
                  try {
                    var response = await newnotemclo(_uploadtext);
                    feedback = response.data["url"];
                  } on Exception catch (_) {
                    feedback = "Error,Please Retry.";
                  }
                  showConDialog(
                      Card(
                          child: MarkdownStringBuilder(
                        ispage: false,
                        string: feedback,
                      )),
                      "Feedback");
                }
              }),
          FilledButton(
              child: Text(getTranslation("upload_file")),
              onPressed: () async {
                var result = await showConfirmDialog(
                    "Notice not to upload too frequent");
                if (result) {
                  String feedback;
                  var upload = await selectlog();
                  if (upload == false) {
                    return;
                  }
                  try {
                    var response = await newnotemclo(upload as String);
                    feedback = response.data["url"];
                  } on Exception catch (_) {
                    feedback = "Error,Please Retry.";

                    // ignore: avoid_print
                    print(_);
                  }
                  showConDialog(
                      Card(
                          child: MarkdownStringBuilder(
                        ispage: false,
                        string: feedback,
                      )),
                      "Feedback");
                }
              })
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

var pageSetting = ScaffoldPage.scrollable(children: [
  MarkdownFileBuilder(
      path: "${getI18nfullPath()}md/settings/part0.md", ispage: false),
]);
