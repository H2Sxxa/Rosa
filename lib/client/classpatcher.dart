import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:rosa/client/get.dart';
import 'package:rosa/config/json.dart';
import 'package:rosa/const.dart';

Directory getGradleCacheRoot() {
  if (!getJsonValue("usemcreator")) {
    return Directory("$userProfile.gradle/");
  } else {
    return Directory("$userProfile.mcreator/gradle/");
  }
}

String findcopyJarfromPackagepath(String packagepath, String name) {
  for (var entry in Directory(
          "${getGradleCacheRoot().path}caches/modules-2/files-2.1/$packagepath")
      .listSync(recursive: true)) {
    if (entry.statSync().type == FileSystemEntityType.file) {
      if (extension(entry.absolute.path) == ".jar") {
        if (basename(entry.absolute.path).contains(name)) {
          return entry.absolute.path;
        }
      }
    }
  }
  return "";
}

String findcopyJar(String name) {
  for (var entry
      in Directory("${getGradleCacheRoot().path}caches/modules-2/files-2.1")
          .listSync(recursive: true)) {
    if (entry.statSync().type == FileSystemEntityType.file) {
      if (extension(entry.absolute.path) == ".jar") {
        if (basename(entry.absolute.path).contains(name)) {
          return entry.absolute.path;
        }
      }
    }
  }
  return "";
}

void patchJar(String path, Map patchmap) async {
  File(path).copy("rosa_Data/caches/${basename(path)}.old");
  var copyf = await File(path).copy("rosa_Data/caches/${basename(path)}");
  var targetRoot =
      "rosa_Data/caches/${basenameWithoutExtension(path)}_patchcache/";
  //await extractFileToDisk(copyf.path, targetRoot);
  final inputStream = InputFileStream(copyf.path);
  final archive = ZipDecoder().decodeBuffer(inputStream);
  for (var file in archive.files) {
    if (file.isFile) {
      final outputStream = OutputFileStream('$targetRoot${file.name}');
      file.writeContent(outputStream);
      outputStream.close();
    }
  }
  for (var i in patchmap["manifest"]) {
    Dio().download(getGithubUri(i["uri"]), targetRoot + i["location"]);
  }
}

void repackJar() {}
void replaceJar() {
  var rmdirt = Directory("${getGradleCacheRoot().path}caches/modules-2/jars-9");
  if (rmdirt.existsSync()) {
    rmdirt.deleteSync(recursive: true);
  }
}
