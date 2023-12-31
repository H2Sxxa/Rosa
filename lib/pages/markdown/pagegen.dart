import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:rosa/config/json.dart';
import 'package:url_launcher/url_launcher_string.dart';

void launchLinkfromString(String text, String? href) async {
  try {
    await launchUrlString(text);
  } on Exception catch (_) {
    try {
      await launchUrlString(href!);
    } on Exception catch (_) {}
  }
}

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
      textScaleFactor: getJsonValue("textscale"),
      h1: commonstyle,
      h2: commonstyle,
      h3: commonstyle,
      h4: commonstyle,
      h5: commonstyle,
      h6: commonstyle,
      a: commonstyle,
      p: commonstyle,
      code: commonstyle.copyWith(fontStyle: FontStyle.italic),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ispage) {
      return Markdown(
          onTapLink: (text, href, title) => launchLinkfromString(text, href),
          data: string,
          styleSheet: getTheme(context));
    } else {
      return MarkdownBody(
          onTapLink: (text, href, title) => launchLinkfromString(text, href),
          data: string,
          styleSheet: getTheme(context));
    }
  }
}
