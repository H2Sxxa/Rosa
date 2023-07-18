import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:rosa/config/json.dart';

void initConfig() {
  initJsonMap({
    "localization": "zh_cn",
    "fontfamily": "default",
    "title": "ROSA - Setup the dev environment",
    "thememode": 0,
    "textscale": 1.2,
    "usemcreator": false,
    "ghproxy": "https://ghproxy.com/",
    "wineffect": 0
  });

  initManifestMap({
    "jdk8": {
      "name": "adoptopenjdk-8-x64-windows.zip",
      "uri":
          "https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u312-b07/OpenJDK8U-jdk_x64_windows_hotspot_8u312b07.zip"
    },
    "jdk16": {
      "name": "adoptopenjdk-16-x64-windows.zip",
      "uri":
          "https://github.com/adoptium/temurin16-binaries/releases/download/jdk-16.0.2%2B7/OpenJDK16U-jdk_x64_windows_hotspot_16.0.2_7.zip"
    },
    "jdk17": {
      "name": "adoptopenjdk-17-x64-windows.zip",
      "uri":
          "https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.1%2B12/OpenJDK17U-jdk_x64_windows_hotspot_17.0.1_12.zip"
    },
  });

  initTranslation({
    "home": "主页",
    "about": "关于",
    "settings": "设置",
    "pastebin": "粘贴板",
    "tookit": "工具箱",
    "download": "下载",
    "doc": "文档",
    "upload_text": "上传文本",
    "upload_file": "上传文件",
    "system": "系统",
    "dark": "深色",
    "light": "浅色",
    "thememode": "主题模式",
    "feedback": "结果",
    "start": "启动",
    "regist": "注册",
    "importset": "导入设置",
    "notice_upload": "注意不要上传过于频繁",
    "erroretry": "错误，请重试",
    "classpatcher": "镜像修补",
    "ghproxy": "Github代理",
    "none": "无",
    "true": "是",
    "false": "否",
    "usemcreator": "使用MCreator",
    "confirm": "确认",
    "ok": "好的",
    "cancel": "取消",
    "mica": "云母",
    "acrylic": "亚克力",
    "fontfamily": "字体",
    "wineffect": "窗口效果",
    "logfile": "日志文件",
    "finish": "完成",
    "cantfindfile": "找不到文件",
    "info": "通知",
    "start_task": "开始任务",
    "error": "错误",
    "warn": "警告",
    "psi": "下载代理功能文件包",
    "register": "注册",
    "p3": "导入配置",
    "aero": "毛玻璃 （Aero）",
    "tabbed": "新云母（Tabbed）",
    "title": "标题",
    "localization": "本地化",
    "textscale": "字体缩放",
    "log": "日志",
    "refresh": "刷新",
    "lang": "语言"
  });
}

Future<List<String>> initFontFamilies() async {
  List<String> result = ["default"];
  for (var entry in Directory("C:/Windows/Fonts").listSync()) {
    var entryfile = File(entry.absolute.path);
    if (entryfile.statSync().type == FileSystemEntityType.file) {
      if (extension(entryfile.path).toLowerCase() == ".ttf") {
        String familyname = basenameWithoutExtension(entryfile.path);
        Uint8List bytes = entryfile.readAsBytesSync();
        loadFontFromList(bytes, fontFamily: familyname);
        result.add(familyname);
      }
    }
  }
  return result;
}
