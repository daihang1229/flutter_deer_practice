import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_deer_dev/res/colors.dart';
import 'package:flutter_deer_dev/routers/Application.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';

import 'home/splash_page.dart';
import 'routers/routers.dart';

void main() {
  runApp(MyApp());
  //沉浸式状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle style =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatelessWidget {

  MyApp() {
    final router = Router();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
     child: MaterialApp(
        title: 'Flutter Deer',
        theme: ThemeData(
          primaryColor: Colours.app_main,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: SplashPage(),
        onGenerateRoute: Application.router.generator,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('zh','CH'),
          const Locale('en','US')
        ],
      ),
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      radius: 20,
      position: ToastPosition.bottom,
    );
  }
}
