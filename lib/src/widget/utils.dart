import 'package:flutter/material.dart';
import 'package:newz/src/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);
  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;
  Color get getColor => getTheme ? Colors.white : Colors.black;
}
