import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rosa/config/i18n.dart';

//const
const localizationPath = 'rosa_Data/i18n/';
const configPath = "rosa_Data/config.json";
const manifestPath = "rosa_Data/manifest.json";
const pluginsPath = "rosa_Data/plugins/";
//final
final userProfile = "${Platform.environment["USERPROFILE"]}/";
final allI18n = getAllI18n();
//late
late List<String> systemFontFamilies;

//sizedBox

const sizedBox20 = SizedBox(
  height: 20,
);

const sizedBox40 = SizedBox(
  height: 40,
);
