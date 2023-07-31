import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/client/get.dart';
import 'package:rosa/config/json.dart';
import 'package:rosa/const.dart';
import 'package:rosa/main.dart';
import 'package:rosa/pages/widgets/prompts.dart';
import 'package:win32_registry/win32_registry.dart';

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
              appLogger.i("Try to get Proxy package");
              try {
                await Dio().download(
                    getGithubUri(getGithubUriMap(
                        "https://github.com/H2Sxxa/Rosa/blob/bin/application/proxy.zip",
                        "https://github.com/H2Sxxa/Rosa/raw/bin/application/proxy.zip")),
                    "rosa_Data/bin/proxy.zip");
              } on Exception catch (_) {
                appLogger.e(_.toString());
              }
            }
            var executer = await get7zExecuter();
            executer.unzipSync(
                File("rosa_Data/bin/proxy.zip"), Directory("rosa_Data/bin"));
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
    appLogger.e(_.toString());
    showConDialog(Text(_.toString()), getTranslation("feedback"));
    return;
  }
  showConDialog(Text(getTranslation("finish")), getTranslation("feedback"));
}

void setupJDKs(List jdks) async {
  String feedbacktext = "";
  appLogger.i(jdks);
  for (Map jdk in jdks) {
    var name = jdk["name"];
    appLogger.i("Start download JDK $name");
    var uri = getGithubUri(getGithubUriMap(jdk["uri"], jdk["uri"]));
    try {
      String pathto;
      if (getJsonValue("usemcreator")) {
        pathto = "$userProfile.mcreator/gradle/jdks/";
      } else {
        pathto = "$userProfile.gradle/jdks/";
      }

      await Dio().download(uri, pathto+name);
      feedbacktext = "$feedbacktext$name from $uri \n";
      appLogger.i(feedbacktext);
    } on Exception catch (_) {
      feedbacktext = "$feedbacktext$_\n";
      appLogger.e(feedbacktext);
    }
  }
  showConDialog(Text(feedbacktext), getTranslation("feedback"));
}
