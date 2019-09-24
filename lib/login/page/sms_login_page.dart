import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer_dev/res/colors.dart';
import 'package:flutter_deer_dev/res/styles.dart';
import 'package:flutter_deer_dev/routers/fluro_navigator.dart';
import 'package:flutter_deer_dev/util/toast.dart';
import 'package:flutter_deer_dev/util/utils.dart';
import 'package:flutter_deer_dev/widgets/app_bar.dart';
import 'package:flutter_deer_dev/widgets/my_button.dart';
import 'package:flutter_deer_dev/widgets/text_field.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../login_router.dart';

class SmsLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SmsLoginState();
  }
}

class SmsLoginState extends State<SmsLogin> {
  var _phoneController = TextEditingController();
  var _vCodeController = TextEditingController();
  var _phoneFocus = FocusNode();
  var _vCodeFocus = FocusNode();
  var config;
  var _isClick = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_verify);
    _vCodeController.addListener(_verify);
    config = Utils.getKeyboardActionsConfig([_phoneFocus, _vCodeFocus]);
  }

  void _verify() {
    var name = _phoneController.text;
    var vCode = _vCodeController.text;
    var click = true;
    if (name.isEmpty || name.length < 11) {
      click = false;
    }
    if (vCode.isEmpty || vCode.length < 6) {
      click = false;
    }
    if (_isClick != click) {
      setState(() {
        _isClick = click;
      });
    }
  }

  void _login() {
    Toast.show("去登录......");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppbar(),
        body: defaultTargetPlatform == TargetPlatform.iOS ? FormKeyboardActions(
          child: _buildBody(),
        ) : SingleChildScrollView(
          child: _buildBody(),
        )
    );
  }

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text("验证码登录",
              style: TextStyles.textBoldDark26),
          Gaps.vGap16,
          MyTextField(
            focusNode: _phoneFocus,
            config: config,
            controller: _phoneController,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: "请输入手机号",
          ),
          Gaps.vGap8,
          MyTextField(
            focusNode: _vCodeFocus,
            controller: _vCodeController,
            maxLength: 6,
            keyboardType: TextInputType.number,
            hintText: "请输入验证码",
            getVCode: () {
              Toast.show('获取验证码');
              return Future.value(true);
            },
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              child: RichText(
                  text: TextSpan(
                      text: "提示：未注册账号的手机号，请先",
                      style: TextStyles.textGray14,
                      children: <TextSpan>[
                        TextSpan(text: "注册",
                            style: TextStyle(color: Colours.text_red)),
                        TextSpan(text: ".", style: TextStyles.textGray14)
                      ]
                  )
              ),
              onTap: () {
                NavigatorUtil.push(context, LoginRouter.registerPage);
              },
            ),
          ),
          Gaps.vGap15,
          Gaps.vGap10,
          MyButton(
            onPressed: _isClick ? _login : null,
            text: "登录",
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 40,
            child: GestureDetector(
              child: const Text("忘记密码",
              style: TextStyles.textGray12,),
              onTap: (){
                NavigatorUtil.push(context, LoginRouter.resetPasswordPage);
              },
            ),
          )
        ],
      ),
    );
  }
}
