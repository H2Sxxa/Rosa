import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/client/execute.dart';
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

List<String> _proxySelect = [];
var pageProxy = ScaffoldPage.scrollable(children: [
  MarkdownFileBuilder(path: "${getI18nfullPath()}md/proxy.md", ispage: false),
  TreeView(
      selectionMode: TreeViewSelectionMode.multiple,
      onSelectionChanged: (selectedItems) async {
        _proxySelect = [];
        for (var item in selectedItems) {
          _proxySelect.add(item.value);
        }
      },
      items: [
        TreeViewItem(
            content: const Text("Install Proxy package"), value: "psi"),
        TreeViewItem(content: const Text("Proxifier"), value: "p0", children: [
          TreeViewItem(content: const Text("register"), value: "p1"),
          TreeViewItem(content: const Text("Start"), value: "p2"),
          TreeViewItem(content: const Text("Import setting"), value: "p3"),
        ]),
        TreeViewItem(
            content: const Text("Shadowsocks"),
            value: "s0",
            children: [
              TreeViewItem(content: const Text("Start"), value: "s1")
            ]),
      ]),
  FilledButton(
      child: const Text("Run it!"),
      onPressed: () {
        runProxyTasks(_proxySelect);
      })
]);

var _jdks = [];
var pageDownload = ScaffoldPage.scrollable(children: [
  MarkdownFileBuilder(
      path: "${getI18nfullPath()}md/download/part0.md", ispage: false),
  TreeView(
      selectionMode: TreeViewSelectionMode.multiple,
      onSelectionChanged: (selectedItems) async {
        _jdks = [];
        for (var i in selectedItems) {
          _jdks.add(i.value);
        }
      },
      items: [
        TreeViewItem(content: const Text("JDK"), value: "0", children: [
          TreeViewItem(content: const Text("JDK 17"), value: "17"),
          TreeViewItem(content: const Text("JDK 16"), value: "16"),
          TreeViewItem(content: const Text("JDK 8"), value: "8")
        ])
      ])
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

var pageSettings = ScaffoldPage.scrollable(children: [
  MarkdownFileBuilder(
      path: "${getI18nfullPath()}md/settings/part0.md", ispage: false),
]);