import 'package:rosa/client/get.dart';
import 'package:win32_registry/win32_registry.dart';

void registProxifier() {
  try {
    final point = Registry.openPath(RegistryHive.localMachine,
        path: r"SOFTWARE\Initex\Proxifier\License");
    var owner = const RegistryValue("Owner", RegistryValueType.string, "ROSA");
    var key = const RegistryValue(
        "Key", RegistryValueType.string, "5EZ8G-C3WL5-B56YG-SCXM9-6QZAP");
    point.createValue(owner);
    point.createValue(key);
  } on Exception catch (_) {
    final point = Registry.openPath(RegistryHive.currentUser,
        path: r"SOFTWARE\Initex\Proxifier\License");
    var owner = const RegistryValue("Owner", RegistryValueType.string, "ROSA");
    var key = const RegistryValue(
        "Key", RegistryValueType.string, "5EZ8G-C3WL5-B56YG-SCXM9-6QZAP");
    point.createValue(owner);
    point.createValue(key);
  }
}

void runProxyTasks(List<String> ptasks, List<String> stasks) async {
  for (var ptaskname in ptasks) {
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

  for (var staskname in ptasks) {
    switch (staskname) {
      case "s1":
        getfile("uri", "path");
        break;
      case "s2":
        break;
      default:
        break;
    }
  }
}
