import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:rosa/client/get.dart';
import 'package:rosa/config/json.dart';
import 'package:rosa/const.dart';
import 'package:rosa/main.dart';

Directory getGradleCacheRoot() {
  if (!getJsonValue("usemcreator")) {
    return Directory("$userProfile.gradle/");
  } else {
    return Directory("$userProfile.mcreator/gradle/");
  }
}

Future<String> findcopyJarfromPackagepath(
    String packagepath, String name) async {
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

Future<void> patchJar(String path, List patchmaplist) async {
  if (!Directory("rosa_Data/caches").existsSync()) {
    Directory("rosa_Data/caches").createSync(recursive: true);
  }
  if (File(absolute("rosa_Data/caches/${basename(path)}.old")).existsSync()) {
    File(absolute("rosa_Data/caches/${basename(path)}.old")).deleteSync();
  }
  File(path).copySync(absolute("rosa_Data/caches/${basename(path)}.old"));
  for (var i in patchmaplist) {
    try {
      appLogger.i("download", i);
      await Dio().download(getGithubUri(i["uri"]),
          "rosa_Data/caches/${basenameWithoutExtension(path)}/${i["location"]}");
    } on Exception catch (_) {
      appLogger.e(_.toString());
    }
  }
  var executer = await get7zExecuter();
  for (var i in Directory("rosa_Data/caches/${basenameWithoutExtension(path)}")
      .listSync()) {
    executer.addFilefromDirSync(File(path), i);
  }

  var rmdirt = Directory("${getGradleCacheRoot().path}caches/jars-9");
  if (rmdirt.existsSync()) {
    rmdirt.delete(recursive: true);
  }
}

Future<String> doClassPatcher(String pluginname) async {
  appLogger.i("select fg", pluginname);
  try {
    var infomap = jsonDecode((await Dio().get(getGithubUri(getGithubUriMap(
            "https://github.com/H2Sxxa/Rosa/blob/bin/forgegradle/class/$pluginname/package.json",
            "https://github.com/H2Sxxa/Rosa/raw/bin/forgegradle/class/$pluginname/package.json"))))
        .data);
    var jarpath =
        await findcopyJarfromPackagepath(infomap["package"], infomap["name"]);
    if (jarpath == "") {
      return getTranslation("cantfindfile");
    }
    await patchJar(jarpath, infomap["manifest"]);
  } on Exception catch (_) {
    appLogger.e(_.toString());
    return _.toString();
  }
  
  return getTranslation("finish");
}
