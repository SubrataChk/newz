import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newz/src/global/theme_data.dart';
import 'package:newz/src/model/news_model.dart';
import 'package:newz/src/provider/news_provider.dart';
import 'package:newz/src/view/home/home.dart';
import 'package:newz/src/provider/dark_theme_provider.dart';
import 'package:newz/src/view/splash/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider darkThemeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    darkThemeProvider.setDarkTheme =
        await darkThemeProvider.darkThemePref.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => darkThemeProvider),
        ChangeNotifierProvider(
          create: (_) => NewsProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Consumer<DarkThemeProvider>(
            builder: (context, themeProvider, child) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: "NewZ",
                theme: Styles.themeData(themeProvider.getDarkTheme, context),
                home: SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
