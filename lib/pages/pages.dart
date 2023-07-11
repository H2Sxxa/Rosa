import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:rosa/client/classpatcher.dart';
import 'package:rosa/client/execute.dart';
import 'package:rosa/client/get.dart';
import 'package:rosa/client/post.dart';
import 'package:rosa/config/json.dart';
import 'package:rosa/const.dart';
import 'package:rosa/main.dart';
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
  Card(
    child: TreeView(
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
          TreeViewItem(
              content: const Text("Proxifier"),
              value: "p0",
              children: [
                TreeViewItem(content: const Text("register"), value: "p1"),
                TreeViewItem(content: const Text("Start"), value: "p2"),
                TreeViewItem(
                    content: const Text("Import setting"), value: "p3"),
              ]),
          TreeViewItem(
              content: const Text("Shadowsocks"),
              value: "s0",
              children: [
                TreeViewItem(content: const Text("Start"), value: "s1")
              ]),
        ]),
  ),
  FilledButton(
      child: const Text("Run it!"),
      onPressed: () {
        showInfoBar(getTranslation("info"), getTranslation("start_task"));
        runProxyTasks(_proxySelect);
      })
]);

final lazyPatcherTarget = [
  TreeViewItem(
    content: const Text('GradlePlugins'),
    value: "",
    lazy: true,
    children: [],
    onExpandToggle: (item, getsExpanded) async {
      if (item.children.isNotEmpty) return;
      var resp = await Dio().get(getGithubUri(getGithubUriMap(
          "https://github.com/H2Sxxa/Rosa/blob/bin/forgegradle/class/pkg.support.json",
          "https://github.com/H2Sxxa/Rosa/raw/bin/forgegradle/class/pkg.support.json")));
      for (String i in jsonDecode(resp.data)["supports"]) {
        item.children
            .add(TreeViewItem(content: Text(i.toUpperCase()), value: i));
      }
    },
  ),
];

var _uploadValue = "";
var pageClassPatcher = ScaffoldPage.scrollable(children: [
  MarkdownFileBuilder(
    path: "${getI18nfullPath()}md/classpatcher.md",
    ispage: false,
  ),
  Card(
    child: TreeView(
        selectionMode: TreeViewSelectionMode.single,
        shrinkWrap: true,
        items: lazyPatcherTarget,
        onSelectionChanged: (selectedItems) async {
          _uploadValue = selectedItems.first.value;
        }),
  ),
  FilledButton(
      child: const Text("patch"),
      onPressed: () async {
        if (_uploadValue == "") {
          return;
        }
        await showConDialog(Text(await compute(doClassPatcher, _uploadValue)),
            getTranslation("feedback"));
      })
]);

var _jdks = [];
var pageDownload = ScaffoldPage.scrollable(children: [
  MarkdownFileBuilder(
      path: "${getI18nfullPath()}md/download/part0.md", ispage: false),
  Card(
    child: TreeView(
        selectionMode: TreeViewSelectionMode.multiple,
        onSelectionChanged: (selectedItems) async {
          _jdks = [];
          for (var i in selectedItems) {
            if (i.value != "0") {
              _jdks.add(getManifest(i.value));
            }
          }
        },
        items: [
          TreeViewItem(content: const Text("JDK"), value: "0", children: [
            TreeViewItem(content: const Text("JDK 17"), value: "jdk17"),
            TreeViewItem(content: const Text("JDK 16"), value: "jdk16"),
            TreeViewItem(content: const Text("JDK 8"), value: "jdk8")
          ])
        ]),
  ),
  FilledButton(
      child: Text(getTranslation("download")),
      onPressed: () {
        setupJDKs(_jdks);
      }),
]);

var pageAbout = MarkdownFileBuilder(
  path: "${getI18nfullPath()}md/about.md",
  ispage: true,
);

var pageDoc = ScaffoldPage.scrollable(children: [
  MarkdownFileBuilder(path: "${getI18nfullPath()}md/doc.md", ispage: false),
  sizedBox20,
  Card(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ComboBox(
          placeholder: const Text("document list"),
          items: const [ComboBoxItem(child: Text("dev"))],
          onChanged: (value) => {},
        ),
        Button(child: const Text("open"), onPressed: () {})
      ],
    ),
  ),
]);

var _uploadtext = '';
var pagePastebin = ScaffoldPage.scrollable(children: [
  MarkdownFileBuilder(
      path: "${getI18nfullPath()}md/pastebin.md", ispage: false),
  sizedBox20,
  Card(
      child: Wrap(
    children: [
      sizedBox40,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FilledButton(
              child: Text(getTranslation("upload_text")),
              onPressed: () async {
                var result =
                    await showConfirmDialog(getTranslation("notice_upload"));
                if (result) {
                  showInfoBar(
                      getTranslation("info"), getTranslation("start_task"));
                  String feedback;
                  try {
                    var response = await newnotemclo(_uploadtext);
                    feedback = response.data["url"];
                  } on Exception catch (_) {
                    feedback = getTranslation("erroretry");
                    appLogger.e(_.toString());
                  }
                  showConDialog(
                      Card(
                          child: MarkdownStringBuilder(
                        ispage: false,
                        string: feedback,
                      )),
                      getTranslation("feedback"));
                }
              }),
          FilledButton(
              child: Text(getTranslation("upload_file")),
              onPressed: () async {
                var result =
                    await showConfirmDialog(getTranslation("notice_upload"));
                if (result) {
                  String feedback;
                  showInfoBar(
                      getTranslation("info"), getTranslation("start_task"));
                  var upload = await selectlog();
                  if (upload == false) {
                    return;
                  }
                  try {
                    var response = await newnotemclo(upload as String);
                    feedback = response.data["url"];
                  } on Exception catch (_) {
                    feedback = getTranslation("erroretry");
                    appLogger.v(_.toString());
                  }
                  showConDialog(
                      Card(
                          child: MarkdownStringBuilder(
                        ispage: false,
                        string: feedback,
                      )),
                      getTranslation("feedback"));
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
  sizedBox20,
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ComboBox(
        placeholder: Text(getTranslation("thememode")),
        items: [
          ComboBoxItem(
            value: 0,
            child: Text(getTranslation("system")),
          ),
          ComboBoxItem(
            value: -1,
            child: Text(getTranslation("dark")),
          ),
          ComboBoxItem(
            value: 1,
            child: Text(getTranslation("light")),
          ),
        ],
        onChanged: (value) {
          writeJsonValue("thememode", value);
          refreshState();
        },
      ),
      ComboBox(
        placeholder: Text(getTranslation("wineffect")),
        items: [
          ComboBoxItem(value: 0, child: Text(getTranslation("none"))),
          ComboBoxItem(value: 1, child: Text(getTranslation("mica"))),
          ComboBoxItem(value: 2, child: Text(getTranslation("acrylic"))),
        ],
        onChanged: (value) async {
          writeJsonValue("wineffect", value);
          await Window.setEffect(
            effect: getWinEffect(),
          );
          refreshState();
        },
      ),
      ComboBox(
        placeholder: Text(getTranslation("font")),
        items: List<ComboBoxItem>.generate(
            systemFontFamilies.length,
            (index) => ComboBoxItem(
                  value: systemFontFamilies[index],
                  child: Text(systemFontFamilies[index]),
                )),
        onChanged: (value) {
          writeJsonValue("fontfamily", value);
          refreshState();
        },
      ),
    ],
  ),
  sizedBox40,
  MarkdownFileBuilder(
      path: "${getI18nfullPath()}md/settings/part1.md", ispage: false),
  sizedBox20,
  NumberBox(
    value: getJsonValue("textscale") as double,
    onChanged: (value) => writeJsonValue("textscale", value),
    smallChange: 0.1,
    mode: SpinButtonPlacementMode.none,
  ),
  sizedBox40,
  MarkdownFileBuilder(
      path: "${getI18nfullPath()}md/settings/part2.md", ispage: false),
  sizedBox20,
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ComboBox(
        placeholder: Text(getTranslation("ghproxy")),
        items: [
          const ComboBoxItem(
            value: "https://ghproxy.net/",
            child: Text("ghproxy.net"),
          ),
          const ComboBoxItem(
              value: "https://ghproxy.com/", child: Text("ghproxy.com")),
          ComboBoxItem(value: "", child: Text(getTranslation("none")))
        ],
        onChanged: (value) => writeJsonValue("ghproxy", value),
      ),
      ComboBox(
        placeholder: Text(getTranslation("usemcreator")),
        items: [
          ComboBoxItem(
            value: true,
            child: Text(getTranslation("true")),
          ),
          ComboBoxItem(value: false, child: Text(getTranslation("false"))),
        ],
        onChanged: (value) => writeJsonValue("usemcreator", value),
      )
    ],
  )
]);
