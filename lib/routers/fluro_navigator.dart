import 'package:common_utils/common_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer_dev/routers/routers.dart';

import 'Application.dart';

class NavigatorUtil {
  static push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Application.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.material);
  }

  static pushResult(
      BuildContext context, String path, Function(Object) function,
      {bool replace = false, bool clearStack = false}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Application.router
        .navigateTo(context, path,
            replace: replace,
            clearStack: clearStack,
            transition: TransitionType.native)
        .then((result) {
      if (result != null) {
        function(result);
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  static goBack(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.pop(context);
  }

  static goBackWithParams(BuildContext context, param) {
    FocusScope.of(context).requestFocus(new FocusNode());
    Navigator.pop(context, param);
  }

  static goWebViewPage(BuildContext context, String title, String url) {
    push(context,
        '${Routers.webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }
}
