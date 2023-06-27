import 'package:fluent_ui/fluent_ui.dart';
import 'package:rosa/client/get.dart';
import 'package:rosa/pages/widgets/prompts.dart';
import 'package:win32_registry/win32_registry.dart';
import 'package:open_file/open_file.dart';

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
  for (var ptaskname in tasks) {
    switch (ptaskname) {
      case "p1":
        getfile("uri", "path");
        break;
      case "p2":
        registProxifier();
        break;
      default:
        break;
    }
  }

  for (var staskname in tasks) {
    switch (staskname) {
      case "s1":
        getfile("uri", "path");
        break;
      case "s2":
        OpenFile.open("");
        break;
      default:
        break;
    }
  }
}
