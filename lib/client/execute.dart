import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/client/get.dart';
import 'package:rosa/config/json.dart';
import 'package:rosa/const.dart';
import 'package:rosa/pages/widgets/prompts.dart';
import 'package:win32_registry/win32_registry.dart';
import 'package:archive/archive_io.dart';

void unzip(String path, String out) {
  final bytes = File(path).readAsBytesSync();

  // Decode the Zip file
  final archive = ZipDecoder().decodeBytes(bytes);

  // Extract the contents of the Zip archive to disk.
  for (final file in archive) {
    final filename = file.name;
    if (file.isFile) {
      final data = file.content as List<int>;
      File(out + filename)
        ..createSync(recursive: true)
        ..writeAsBytesSync(data);
    } else {
      Directory(out + filename).create(recursive: true);
    }
  }
}

void registProxifier() {
  try {
    final point = Registry.openPath(RegistryHive.localMachine,
        path: r"SOFTWARE\Initex\Proxifier\License",
        desiredAccessRights: AccessRights.allAccess);
    var owner = const RegistryValue("Owner", RegistryValueType.string, "ROSA");
    var key = const RegistryValue(
        "Key", RegistryValueType.string, "5EZ8G-C3WL5-B56YG-SCXM9-6QZAP");
    point.createValue(owner);
    point.createValue(key);
  } on Exception catch (_) {
    try {
      final point = Registry.openPath(RegistryHive.currentUser,
          path: r"SOFTWARE\Initex\Proxifier\License",
          desiredAccessRights: AccessRights.allAccess);
      var owner =
          const RegistryValue("Owner", RegistryValueType.string, "ROSA");
      var key = const RegistryValue(
          "Key", RegistryValueType.string, "5EZ8G-C3WL5-B56YG-SCXM9-6QZAP");
      point.createValue(owner);
      point.createValue(key);
    } on Exception catch (_) {
      showConDialog(Text(_.toString()), "Error");
    }
  }
}

void runProxyTasks(List<String> tasks) async {
  try {
    for (var taskname in tasks) {
      switch (taskname) {
        case "psi":
          {
            if (!File("rosa_Data/bin/proxy.zip").existsSync()) {
              await getfile(
                  getGithubStuffUri(
                      "https://github.com/H2Sxxa/Rosa/blob/bin/application/proxy.zip"),
                  "rosa_Data/bin/proxy.zip");
            }
            unzip("rosa_Data/bin/proxy.zip", "rosa_Data/bin/");
            Process.runSync(
                "start",
                [
                  (File("rosa_Data/bin/proxy/ProxifierSetup.exe")
                      .absolute
                      .path),
                  "/silent"
                ],
                runInShell: true);
          }
          break;
        case "p1":
          registProxifier();
          break;
        case "p2":
          Process.run(
              "start",
              [
                "",
                (File("C:/Program Files (x86)/Proxifier/Proxifier.exe")
                    .absolute
                    .path),
              ],
              runInShell: true);
          break;
        case "p3":
          Process.runSync(
              "start",
              [
                (File("C:/Program Files (x86)/Proxifier/Proxifier.exe")
                    .absolute
                    .path),
                File("rosa_Data/bin/proxy/Minecraft.ppx").absolute.path,
                "silent-load"
              ],
              runInShell: true);
          break;
        case "s1":
          Process.run(
              "start",
              [
                "",
                (File("rosa_Data/bin/proxy/Shadowsocks.exe").absolute.path),
              ],
              runInShell: true);
          break;
        default:
          break;
      }
    }
  } on Exception catch (_) {
    showConDialog(Text(_.toString()), "Result");
    return;
  }
  showConDialog(const Text("All Finish"), "Result");
}

void setupJDKs(List jdks) async {
  String feedbacktext = "";
  for (Map jdk in jdks) {
    var name = jdk["name"];
    var uri = getGithubStuffUri(jdk["uri"]);
    try {
      await Dio().downloadUri(
          Uri.parse(uri), "$userProfile.mcreator/gradle/jdks/$name");
      feedbacktext = "$feedbacktext$name from $uri \n";
    } on Exception catch (_) {
      feedbacktext = "$feedbacktext$_\n";
    }
  }
  showConDialog(Text(feedbacktext), getTranslation("feedback"));
}
