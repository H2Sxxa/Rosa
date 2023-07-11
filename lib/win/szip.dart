import 'dart:io';

import 'package:rosa/main.dart';

class SZaExecuter {
  String exepath;
  SZaExecuter(this.exepath);
  void addFilefromDirSync(
      FileSystemEntity archivepath, FileSystemEntity addpath) {
    var res = Process.runSync(
      exepath,
      ["a", archivepath.absolute.path, addpath.absolute.path],
    );
    appLogger.i(res.stdout);
    appLogger.e(res.stderr);
  }

  void unzipSync(FileSystemEntity archivepath, FileSystemEntity outpath) {
    var res = Process.runSync(
      exepath,
      ["x", archivepath.absolute.path, "-o${outpath.absolute.path}"],
    );
    appLogger.i(res.stdout);
    appLogger.e(res.stderr);
  }
}
