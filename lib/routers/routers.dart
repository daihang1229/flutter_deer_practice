import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_deer_dev/home/home_page.dart';
import 'package:flutter_deer_dev/login/login_router.dart';
import 'package:flutter_deer_dev/routers/router_init.dart';
import 'package:flutter_deer_dev/shop/shop_router.dart';
import 'package:flutter_deer_dev/store/store_router.dart';

import '404.dart';

class Routers {
  static String home = "/home";
  static String webViewPage = "/webview";
  static List<IRouterProvider> _listRouter = [];
  Router router;

  static void configureRoutes(Router router) {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      debugPrint("未找到目标页");
      return WidgetNotFound();
    });

    router.define(home,
        handler: Handler(
            handlerFunc:
                (BuildContext context, Map<String, List<String>> params) =>
                    HomePage()));

    _listRouter.clear();
    _listRouter.add(LoginRouter());
    _listRouter.add(StoreRouter());
    _listRouter.add(ShopRouter());

    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
