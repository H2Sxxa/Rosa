import 'package:dio/dio.dart';

Future<void> getfile(String uri, String path) async {
  await Dio().download(uri, path);
}

void getfileSync(String uri, String path) {
  Dio().download(uri, path);
}

String getGithubStuffUri(String uri) {
  return "https://ghproxy.net/$uri";
}
