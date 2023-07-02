import 'dart:convert';
import 'dart:io';

import 'package:rosa/const.dart';

List<DocContainer> getDocs() {
  List<DocContainer> result = [];
  for (var entity in Directory("${pluginsPath}doc").listSync()) {
    if (Directory(entity.path).statSync().type ==
        FileSystemEntityType.directory) {
      if (File("${entity.path}/DOC_REFERENCE.json").existsSync()) {
        result.add(DocContainer(entity.path));
      }
    }
  }

  return result;
}

class DocContainer {
  String path;
  late Map reference;
  late List<String> sequence;
  late String docname;
  DocContainer(this.path) {
    reference = jsonDecode(File("$path/DOC_REFERENCE.json").readAsStringSync());
    docname = reference["name"];
    sequence = reference["sequence"];
  }

  List<String> getdocspath() {
    List<String> result = [];
    for (var i in sequence) {
      var mdfile = File("$path/$i");
      if (mdfile.existsSync()) {
        result.add(mdfile.absolute.path);
      }
    }
    return result;
  }
}