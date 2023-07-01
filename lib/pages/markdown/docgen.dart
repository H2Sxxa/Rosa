import 'dart:io';

import 'package:path/path.dart';

List<DocContainer> getDocs() {
  return [];
}

class DocContainer {
  String path;
  DocContainer(this.path) {
    Directory(path);//TODO write here
  }

  String getName() {
    return basename(path);
  }
}
