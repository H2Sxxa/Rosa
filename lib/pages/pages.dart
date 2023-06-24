import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/client/post.dart';
import 'package:rosa/config/json.dart';
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
                    feedback = response.data.toString();
                  } on Exception catch (_) {
                    feedback = "Error";
                  }

                  showConDialog(
                      Card(
                          child: SelectableText(
                        feedback,
                        maxLines: null,
                      )),
                      "Feedback");
                }
              }),
          FilledButton(
              child: Text(getTranslation("upload_file")), onPressed: () {})
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
