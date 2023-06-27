import 'package:dio/dio.dart';

void getfile(String uri, String path) async {
  await Dio().download(uri, path);
}

String getGithubStuffUri(String uri) {
  return "https://ghproxy.net/$uri";
}
