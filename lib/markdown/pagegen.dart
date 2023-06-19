import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownFilePage extends StatelessWidget {
  final String path;
  const MarkdownFilePage({required this.path, super.key});

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: File(path).readAsStringSync(),
      //selectable: true,
      styleSheet: MarkdownStyleSheet(textScaleFactor: 1.25),
    );
  }
}
