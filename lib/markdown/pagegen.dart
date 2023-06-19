import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownFilePage extends StatelessWidget {
  final String path;
  const MarkdownFilePage({required this.path, super.key});

  @override
  Widget build(BuildContext context) {
    return Markdown(data: File(path).readAsStringSync());
  }
}
