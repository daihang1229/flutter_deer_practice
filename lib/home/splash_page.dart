import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer_dev/common/common.dart';
import 'package:flutter_deer_dev/login/page/login_page.dart';
import 'package:flutter_deer_dev/login/login_router.dart';
import 'package:flutter_deer_dev/routers/fluro_navigator.dart';
import 'package:flutter_deer_dev/util/image_utils.dart';
import 'package:flutter_deer_dev/util/toast.dart';

import 'package:flutter_deer_dev/util/utils.dart';
import 'package:flutter_deer_dev/widgets/load_image.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rxdart/rxdart.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _status = 0;
  List<String> _guideList = ["app_start_1", "app_start_2", "app_start_3"];
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SpUtil.getInstance();
      if (SpUtil.getBool(Constant.key_guide, defValue: true)){
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        precacheImage(AssetImage(ImageUtils.getImgPath("app_start_1")), context);
        precacheImage(AssetImage(ImageUtils.getImgPath("app_start_2")), context);
        precacheImage(AssetImage(ImageUtils.getImgPath("app_start_3")), context);
      }
      _initSplash();
    });
  } //  StreamSub

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _goLogin() {
//    Toast.show("我想静静");
    NavigatorUtil.push(context, LoginRouter.loginPage, replace: true);
  }

  void _initSplash() {
    _subscription = Observable.just(1).delay(Duration(seconds: 2)).listen((_) {
      if (SpUtil.getBool(Constant.key_guide, defValue: true)) {
        SpUtil.putBool(Constant.key_guide, false);
        _initGuide();
      } else {
        _goLogin();
      }
    });
  }

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: _status == 1,
            child: Image.asset(
              ImageUtils.getImgPath("start_page", format: "jpg"),
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Offstage(
            offstage: _status == 0,
            child: Swiper(
              itemCount: _guideList.length,
              loop: false,
              itemBuilder: (_, index) {
                return LoadAssetImage(_guideList[index],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill);
              },
              onTap: (index) {
                if (index == _guideList.length - 1) {
                  _goLogin();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
