
import 'package:fluro/fluro.dart';
import 'package:flutter_deer_dev/routers/router_init.dart';
import 'package:flutter_deer_dev/shop/page/address_select_page.dart';
import 'package:flutter_deer_dev/shop/page/shop_page.dart';

class ShopRouter implements IRouterProvider {
  static String shopPage = "/shop";
  static String shopSettingPage = "/shop/shopSetting";
  static String messagePage = "/shop/message";
  static String freightConfigPage = "/shop/freightConfig";
  static String addressSelectPage = "/shop/addressSelect";


  @override
  void initRouter(Router router) {
    router.define(shopPage, handler: Handler(handlerFunc: (_, params) => ShopPage()));
//    router.define(shopSettingPage, handler: Handler(handlerFunc: (_, params) => ShopSettingPage()));
//    router.define(messagePage, handler: Handler(handlerFunc: (_, params) => MessagePage()));
//    router.define(freightConfigPage, handler: Handler(handlerFunc: (_, params) => FreightConfigPage()));
    router.define(addressSelectPage, handler: Handler(handlerFunc: (_, params) => AddressSelectPage()));
  }

}