import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';

class SZaExecuter {
  String exepath;
  SZaExecuter(this.exepath);
  void addFilefromDirSync(
      FileSystemEntity archivepath, FileSystemEntity addpath) {
    debugPrint(addpath.absolute.path);
    var res = Process.runSync(
      exepath,
      ["a", archivepath.absolute.path, addpath.absolute.path],
    );
    debugPrint(res.stdout);
    debugPrint(res.stderr);
  }

  void unzipSync(FileSystemEntity archivepath, FileSystemEntity outpath) {
    var res = Process.runSync(
      exepath,
      ["x", archivepath.absolute.path, "-o${outpath.absolute.path}"],
    );
    debugPrint(res.stdout);
    debugPrint(res.stderr);
  }
}
