import 'package:dio/dio.dart';

Future<Response> newnotemclo(String text) {
  return Dio().postUri(Uri.parse('https://api.mclo.gs/1/log'),
      data: FormData.fromMap({"content": text}));
}
