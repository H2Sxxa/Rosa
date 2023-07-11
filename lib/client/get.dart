import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rosa/config/json.dart';
import 'package:rosa/win/szip.dart';

String getGithubUri(Map urimap) {
  if (getJsonValue("ghproxy") == "") {
    return urimap["raw"];
  } else {
    return getJsonValue("ghproxy") + urimap["blob"];
  }
}

Map getGithubUriMap(String bloburi, String rawuri) {
  return {"blob": bloburi, "raw": rawuri};
}

Future<SZaExecuter> get7zExecuter() async {
  if (!File("rosa_Data/bin/7za.exe").existsSync()) {
    await Dio().download(
        getGithubUri(getGithubUriMap(
            "https://github.com/H2Sxxa/Rosa/blob/bin/application/7za.exe",
            "https://github.com/H2Sxxa/Rosa/raw/bin/application/7za.exe")),
        "rosa_Data/bin/7za.exe");
  }
  return SZaExecuter(File("rosa_Data/bin/7za.exe").absolute.path);
}
