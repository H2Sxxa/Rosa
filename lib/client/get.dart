import 'dart:io';

import 'package:dio/dio.dart';

Future<Response> get(String uri) async {
  return await Dio().getUri(Uri.parse(uri));
}

void getfile(String uri, String path) async {
  var resp = await get(uri);
  await File(path).writeAsBytes(resp.data);
}

