import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';
import 'package:flutter_deer_dev/login/page/login_page.dart';
import 'package:flutter_deer_dev/login/page/register_page.dart';
import 'package:flutter_deer_dev/login/page/reset_password_page.dart';
import 'package:flutter_deer_dev/login/page/sms_login_page.dart';
import 'package:flutter_deer_dev/login/page/update_password_page.dart';
import 'package:flutter_deer_dev/routers/router_init.dart';

class LoginRouter extends IRouterProvider {
  static String loginPage = "/login";
  static String registerPage = "/login/register";
  static String smsLoginPage = "/login/smsLogin";
  static String resetPasswordPage = "/login/resetPassword";
  static String updatePasswordPage = "/login/updatePassword";

  @override
  void initRouter(Router router) {
    router.define(loginPage,
        handler: Handler(handlerFunc: (_, param) => Login()));
    router.define(registerPage,
        handler: Handler(handlerFunc: (_, param) => Register()));
    router.define(smsLoginPage,
        handler: Handler(handlerFunc: (_, param) => SmsLogin()));
    router.define(resetPasswordPage,
        handler: Handler(handlerFunc: (_, param) => ResetPassword()));
    router.define(updatePasswordPage,
        handler: Handler(handlerFunc: (_, param) => UpdatePassword()));
  }

}
