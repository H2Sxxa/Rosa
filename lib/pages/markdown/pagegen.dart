import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:rosa/config/json.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MarkdownFileBuilder extends StatelessWidget {
  final String path;
  final bool ispage;
  const MarkdownFileBuilder(
      {required this.path, required this.ispage, super.key});

  @override
  Widget build(BuildContext context) {
    return MarkdownStringBuilder(
        string: File(path).readAsStringSync(), ispage: ispage);
  }
}

class MarkdownStringBuilder extends StatelessWidget {
  final String string;
  final bool ispage;
  const MarkdownStringBuilder(
      {required this.string, required this.ispage, super.key});

  MarkdownStyleSheet getTheme(BuildContext context) {
    TextStyle commonstyle = TextStyle(fontFamily: getJsonValue("fontfamily"));
    return MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
      textScaleFactor: 1.2,
      h1: commonstyle,
      h2: commonstyle,
      h3: commonstyle,
      h4: commonstyle,
      h5: commonstyle,
      h6: commonstyle,
      a: commonstyle,
      p: commonstyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ispage) {
      return Markdown(
        data: string,
        //selectable: true,
        styleSheet: getTheme(context)
      );
    } else {
      return MarkdownBody(
        onTapLink: (url, string, str) {
          launchUrlString(url);
        },
        data: string,
        //selectable: true,
        styleSheet: getTheme(context)
      );
    }
  }
}
