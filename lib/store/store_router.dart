

import 'package:fluro/fluro.dart';
import 'package:flutter_deer_dev/routers/router_init.dart';
import 'package:flutter_deer_dev/store/store_audit_result_page.dart';

import 'store_audit_page.dart';

class StoreRouter implements IRouterProvider{

  static String auditPage = "/store/audit";
  static String auditResultPage = "/store/auditResult";


  @override
  void initRouter(Router router) {
    router.define(auditPage, handler: Handler(handlerFunc: (_,param) => StoreAuditPage()));
    router.define(auditResultPage, handler: Handler(handlerFunc: (_,param) => StoreAuditResultPage()));
  }

}