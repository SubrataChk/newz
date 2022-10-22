import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newz/src/view/bookmark/bookmark.dart';
import 'package:newz/src/view/home/home.dart';
import 'package:newz/src/widget/custom_list_tiles.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class DrawerSection extends StatefulWidget {
  const DrawerSection({super.key});

  @override
  State<DrawerSection> createState() => _DrawerSectionState();
}

class _DrawerSectionState extends State<DrawerSection> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return Drawer(
      child: Material(
        // color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                    // color: Theme.of(context).primaryColor,
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Flexible(
                      child: Image.asset(
                        "assets/news.png",
                        height: 50.h,
                        width: 50.w,
                        color: Colors.red,
                      ),
                    ),
                    Flexible(
                        child: Text(
                      "NewZ",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18.sp),
                    ))
                  ],
                )),
            CustomListTiles(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePageSection()));
              },
              title: "Home",
              icons: Icons.home,
            ),
            CustomListTiles(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        ctx: context,
                        child: BookMarkPageSection(),
                        type: PageTransitionType.rightToLeft));
              },
              title: "Bookmark",
              icons: Icons.bookmark,
            ),
            Divider(),

            SizedBox(
              height: 10.h,
            ),

            //Theme Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  themeState.getDarkTheme
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  size: 30.w,
                  color: themeState.getDarkTheme
                      ? Colors.greenAccent
                      : Colors.black,
                ),
                Text(
                  themeState.getDarkTheme ? "Light Theme" : "Dark Theme",
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
        ),
      ),
    );
  }
}
