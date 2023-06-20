import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../main.dart';

class MarkdownFilePage extends StatelessWidget {
  final String path;
  const MarkdownFilePage({required this.path, super.key});

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: File(path).readAsStringSync(),
      //selectable: true,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        textScaleFactor: 1.2,
        h1: const TextStyle(fontFamily: globalFontFamily),
        a: const TextStyle(fontFamily: globalFontFamily),
        p: const TextStyle(fontFamily: globalFontFamily),
      ),
    );
  }
}
