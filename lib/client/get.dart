import 'package:dio/dio.dart';

Future<void> getfile(String uri, String path) async {
  await Dio().download(uri, path);
}

void getfileSync(String uri, String path) {
  Dio().download(uri, path);
}

//TODO FINISH HERE
String getGithubStuffUri(String uri) {
  return "https://ghproxy.net/$uri";
}

String getGithubUri(Map uri) {
  return uri["raw"];
}