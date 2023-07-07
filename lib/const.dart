import 'dart:io';

import 'package:flutter/material.dart';

//const
const localizationPath = 'rosa_Data/i18n/';
const configPath = "rosa_Data/config.json";
const manifestPath = "rosa_Data/manifest.json";
const pluginsPath = "rosa_Data/plugins/";
//final
final userProfile = "${Platform.environment["USERPROFILE"]}/";
//late
late List<String> systemFontFamilies;

//sizedBox

const sizedBox20 = SizedBox(
  height: 20,
);

const sizedBox40 = SizedBox(
  height: 40,
);