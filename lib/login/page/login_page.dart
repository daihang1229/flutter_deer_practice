import 'package:common_utils/common_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer_dev/common/common.dart';
import 'package:flutter_deer_dev/res/styles.dart';
import 'package:flutter_deer_dev/routers/fluro_navigator.dart';
import 'package:flutter_deer_dev/store/store_router.dart';
import 'package:flutter_deer_dev/util/toast.dart';
import 'package:flutter_deer_dev/util/utils.dart';
import 'package:flutter_deer_dev/widgets/app_bar.dart';
import 'package:flutter_deer_dev/widgets/my_button.dart';
import 'package:flutter_deer_dev/widgets/text_field.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:flustars/flustars.dart' as FlutterStars;

import '../login_router.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  var _nameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _nodeText1 = FocusNode();
  var _nodeText2 = FocusNode();
  bool _isClick = false;

  KeyboardActionsConfig _config;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);
    _nameController.text = FlutterStars.SpUtil.getString(Constant.phone);
    _config = Utils.getKeyboardActionsConfig([_nodeText1, _nodeText2]);
  }

  void _verify() {
    String name = _nameController.text;
    String password = _passwordController.text;
    var isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  void _login() {
    String name = _nameController.text;
    String password = _passwordController.text;
    if (name.isEmpty || name.length < 11) {
      Toast.show("Please input the right account");
      return;
    }
    if (password.isEmpty || password.length < 6) {
      Toast.show("Password can not be null or it`s length is less than six");
      return;
    }
    FlutterStars.SpUtil.putString(Constant.phone, _nameController.text);
    NavigatorUtil.push(context, StoreRouter.auditPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppbar(
          isBack: false,
          actionName: "验证码登录",
          onPressed: () {
            NavigatorUtil.push(context, LoginRouter.smsLoginPage);
          },
        ),
        body: defaultTargetPlatform == TargetPlatform.iOS
            ? FormKeyboardActions(
                child: _buildBody(),
              )
            : SingleChildScrollView(
                child: _buildBody(),
              ));
  }

  _buildBody() {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            "密码登录",
            style: TextStyles.textBoldDark26,
          ),
          Gaps.vGap16,
          MyTextField(
            focusNode: _nodeText1,
            controller: _nameController,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: "请输入账号",
          ),
          Gaps.vGap8,
          MyTextField(
            focusNode: _nodeText2,
            controller: _passwordController,
            isInputPwd: true,
            config: _config,
            maxLength: 16,
            hintText: "请输入密码",
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            onPressed:  _login,
            text: "登录",
          ),
          Container(
            height: 40,
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: const Text(
                "忘记密码",
                style: TextStyles.textGray12,
              ),
              onTap: () {
                NavigatorUtil.push(context, LoginRouter.resetPasswordPage);
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              child: const Text("还没账号，快去注册一个吧", style:TextStyle(
                color: Colors.blue
              )),
              onTap: () {
                NavigatorUtil.push(context, LoginRouter.registerPage);
              },
            ),
          )
        ],
      ),
    );
  }
}
