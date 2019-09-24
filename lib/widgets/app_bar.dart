import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer_dev/res/colors.dart';
import 'package:flutter_deer_dev/res/styles.dart';
import 'package:flutter_deer_dev/util/dimens.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;

  const MyAppbar(
      {Key key,
      this.backgroundColor = Colors.white,
      this.title = "",
      this.centerTitle = "",
      this.backImg = "assets/images/ic_back_black.png",
      this.actionName = "",
      this.isBack = true,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle _style =
        ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;
    //annotatedRegion 修改状态栏字体颜色
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _style,
      child: Material(
        color: backgroundColor,
        //safe area 屏幕适配  刘海屏等 避免文字遮盖
        child: SafeArea(
            child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: centerTitle.isEmpty
                      ? Alignment.centerLeft
                      : Alignment.center,
                  width: double.infinity,
                  child: Text(
                    title.isEmpty ? centerTitle : title,
                    style: TextStyle(
                      fontSize: Dimens.font_sp18,
                      color: _style == SystemUiOverlayStyle.light
                          ? Colors.white
                          : Colours.text_dark,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                )
              ],
            ),
            isBack
                ? IconButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.maybePop(context);
                    },
                    padding: const EdgeInsets.all(12.0),
                    icon: Image.asset(
                      backImg,
                      color: _style == SystemUiOverlayStyle.dark
                          ? Colours.text_dark
                          : Colors.white,
                    ),
                  )
                : Gaps.empty,
            Positioned(
              right: 0.0,
              child: Theme(
                  data: ThemeData(
                      buttonTheme: ButtonThemeData(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          minWidth: 60.0)),
                  child: actionName.isEmpty
                      ? Container()
                      : FlatButton(
                          child: Text(actionName),
                          textColor: _style == SystemUiOverlayStyle.light
                              ? Colors.white
                              : Colours.text_dark,
                          onPressed: onPressed,
                          highlightColor: Colors.transparent,
                        )),
            )
          ],
        )),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}
