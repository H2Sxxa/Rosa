import 'package:rosa/config/json.dart';

void initConfig() {
  initJsonMap({
    "localization": "zh_cn",
    "fontfamily": "BoldHans",
    "title": "ROSA - Setup the dev environment",
    "thememode": 0
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
          "https://ghproxy.com/https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.1%2B12/OpenJDK17U-jdk_x64_windows_hotspot_17.0.1_12.zip"
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
    "htsetup": "如何正确代理来加速构建环境",
    "upload_text": "上传文本",
    "upload_file": "上传文件",
    "system": "系统",
    "dark": "暗色",
    "light": "亮色",
    "thememode": "主题模式",
    "feedback": "回馈",
    "start": "启动",
    "regist": "注册",
    "importset": "导入设置",
    "notice_upload":"注意不要上传过于频繁",
    "erroretry": "错误，请重试"
  });
}
