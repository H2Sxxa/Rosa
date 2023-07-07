import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:rosa/client/execute.dart';
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
  var copyf =
      File(path).copySync(absolute("rosa_Data/caches/${basename(path)}.old"));
  var targetRoot =
      absolute("rosa_Data/caches/${basenameWithoutExtension(path)}_patch/");
  if (!Directory(targetRoot).existsSync()) {
    await Directory(targetRoot).create(recursive: true);
  }
  await unzip(copyf.path, targetRoot);
  for (var i in patchmaplist) {
    iprint(i);
    await Dio().download(getGithubUri(i["uri"]), targetRoot + i["location"]);
  }
}

Future<void> repackJar(String name, String path) async {
  var rootDir = Directory(path);
  var encoder = ZipFileEncoder();
  encoder.create("${rootDir.parent.path}/$name");
  for (var i in rootDir.listSync()) {
    iprint(i.path);
    if (i.statSync().type == FileSystemEntityType.file) {
      encoder.addFile(File(i.absolute.path));
    } else {
      encoder.addDirectory(Directory(i.absolute.path));
    }
  }
  encoder.close();
}

Future<void> replaceJar(String newpath, String oldpath) async {
  //remove jar-9,let gradle regenerate
  var rmdirt = Directory("${getGradleCacheRoot().path}caches/modules-2/jars-9");
  if (rmdirt.existsSync()) {
    rmdirt.delete(recursive: true);
  }

  var oldjar = File(oldpath);
  if (oldjar.existsSync()) {
    oldjar.delete();
  }

  File(newpath).copy(oldpath);
}

Future<String> doClassPatcher(String pluginname) async {
  var infomap = jsonDecode((await Dio().get(getGithubUri(getGithubUriMap(
          "https://github.com/H2Sxxa/Rosa/blob/bin/forgegradle/class/$pluginname/package.json",
          "https://github.com/H2Sxxa/Rosa/raw/bin/forgegradle/class/$pluginname/package.json"))))
      .data);
  var jarpath =
      await findcopyJarfromPackagepath(infomap["package"], infomap["name"]);
  if (jarpath == "") {
    return "No such file";
  }
  await patchJar(jarpath, infomap["manifest"]);
  await repackJar(basename(jarpath),
      "rosa_Data/caches/${basenameWithoutExtension(jarpath)}_patch/");
  await replaceJar("rosa_Data/caches/${basename(jarpath)}", jarpath);
  return "Finish";
}

void iprint(dynamic obj) {
  // ignore: avoid_print
  print(obj);
}
