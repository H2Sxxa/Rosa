// ignore: depend_on_referenced_packages
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:rosa/config/json.dart';
import 'package:rosa/main.dart';

Future<Object> selectlog() async {
  XTypeGroup typeGroup = XTypeGroup(
    label: getTranslation("logfile"),
  );
  final XFile? file = await FileSelectorPlatform.instance
      .openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
  if (file == null) {
    return false;
  }
  appLogger.i("select log file", file.path);
  return file.readAsString();
}
