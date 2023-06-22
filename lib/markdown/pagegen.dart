import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:rosa/config/json.dart';

class MarkdownFileBuilder extends StatelessWidget {
  final String path;
  final bool ispage;
  const MarkdownFileBuilder(
      {required this.path, required this.ispage, super.key});

  @override
  Widget build(BuildContext context) {
    if (ispage) {
      return Markdown(
        data: File(path).readAsStringSync(),
        //selectable: true,
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
          textScaleFactor: 1.2,
          h1: TextStyle(fontFamily: getJsonValue("fontfamily")),
          h2: TextStyle(fontFamily: getJsonValue("fontfamily")),
          h3: TextStyle(fontFamily: getJsonValue("fontfamily")),
          h4: TextStyle(fontFamily: getJsonValue("fontfamily")),
          h5: TextStyle(fontFamily: getJsonValue("fontfamily")),
          h6: TextStyle(fontFamily: getJsonValue("fontfamily")),
          a: TextStyle(fontFamily: getJsonValue("fontfamily")),
          p: TextStyle(fontFamily: getJsonValue("fontfamily")),
        ),
      );
    } else {
      return MarkdownBody(
        data: File(path).readAsStringSync(),
        //selectable: true,
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
          textScaleFactor: 1.2,
          h1: TextStyle(fontFamily: getJsonValue("fontfamily")),
          h2: TextStyle(fontFamily: getJsonValue("fontfamily")),
          h3: TextStyle(fontFamily: getJsonValue("fontfamily")),
          h4: TextStyle(fontFamily: getJsonValue("fontfamily")),
          h5: TextStyle(fontFamily: getJsonValue("fontfamily")),
          h6: TextStyle(fontFamily: getJsonValue("fontfamily")),
          a: TextStyle(fontFamily: getJsonValue("fontfamily")),
          p: TextStyle(fontFamily: getJsonValue("fontfamily")),
        ),
      );
    }
  }
}
