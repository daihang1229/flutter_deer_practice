import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer_dev/res/colors.dart';
import 'package:flutter_deer_dev/res/styles.dart';
import 'package:flutter_deer_dev/util/number_text_input_formatter.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class TextFieldItem extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputType inputType;
  final FocusNode focusNode;
  final KeyboardActionsConfig config;

  const TextFieldItem(
      {Key key,
      this.controller,
      @required this.title,
      this.hintText,
      this.inputType,
      this.focusNode,
      this.config})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (config != null && defaultTargetPlatform == TargetPlatform.iOS) {
      // 因Android平台输入法兼容问题，所以只配置IOS平台
      FormKeyboardActions.setKeyboardActions(context, config);
    }
    return Container(
      height: 50,
      margin: const EdgeInsets.only(left: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              bottom: Divider.createBorderSide(context,
                  color: Colours.line, width: 0.6))),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              title,
              style: TextStyles.textDark14,
            ),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              keyboardType: inputType,
              inputFormatters: _getInputFormatters(),
              style: TextStyles.textDark14,
              decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none, //去掉下划线
                  hintStyle: TextStyles.textGrayC14),
            ),
          ),
          Gaps.hGap16
        ],
      ),
    );
  }
  _getInputFormatters(){
    if (inputType == TextInputType.numberWithOptions(decimal: true)){
      return [UsNumberTextInputFormatter()];
    }
    if (inputType == TextInputType.number || inputType == TextInputType.phone){
      return [WhitelistingTextInputFormatter.digitsOnly];
    }
    return null;
  }

}
