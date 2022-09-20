import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newz/src/provider/dark_theme_provider.dart';
import 'package:newz/src/widget/drawer.dart';
import 'package:provider/provider.dart';

class ThemeCheck extends StatelessWidget {
  const ThemeCheck({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerSection(),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(themeState.getDarkTheme
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded),
              Text(
                "Dark Theme",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              CupertinoSwitch(
                  value: themeState.getDarkTheme,
                  onChanged: (bool value) {
                    themeState.setDarkTheme = value;
                  }),
            ],
          )
        ],
      )),
    );
  }
}
