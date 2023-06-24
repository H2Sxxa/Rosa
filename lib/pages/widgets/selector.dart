// ignore: depend_on_referenced_packages
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';

Future<Object> selectlog() async {
  const XTypeGroup typeGroup = XTypeGroup(
    label: "LOG FILE",
  );
  final XFile? file = await FileSelectorPlatform.instance
      .openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
  if (file == null) {
    return false;
  }
  return file.readAsString();
}
