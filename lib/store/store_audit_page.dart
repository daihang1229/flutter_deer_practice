import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_amap/flutter_2d_amap.dart';
import 'package:flutter_deer_dev/res/styles.dart';
import 'package:flutter_deer_dev/routers/fluro_navigator.dart';
import 'package:flutter_deer_dev/routers/routers.dart';
import 'package:flutter_deer_dev/shop/shop_router.dart';
import 'package:flutter_deer_dev/store/store_router.dart';
import 'package:flutter_deer_dev/util/toast.dart';
import 'package:flutter_deer_dev/widgets/app_bar.dart';
import 'package:flutter_deer_dev/widgets/my_button.dart';
import 'package:flutter_deer_dev/widgets/selected_image.dart';
import 'package:flutter_deer_dev/widgets/store_select_text_item.dart';
import 'package:flutter_deer_dev/widgets/text_field_item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class StoreAuditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new StoreAuditState();
  }
}

class StoreAuditState extends State<StoreAuditPage> {
  File _imageFile;
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  KeyboardActionsConfig _config;
  String _address = "北京 朝阳 三里屯 屯里";

  @override
  void initState() {
    super.initState();
    _config = _buildConfig();
  }

  void _getImage() async {
    try {
      _imageFile = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxWidth: 800, imageQuality: 95);
      setState(() {});
    } catch (e) {
      Toast.show("没有权限打开相册");
    }
  }

  KeyboardActionsConfig _buildConfig() {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nodeText1,
          displayCloseWidget: false,
        ),
        KeyboardAction(
          focusNode: _nodeText2,
          displayCloseWidget: false,
        ),
        KeyboardAction(
          focusNode: _nodeText3,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: const Text("关闭"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(
        centerTitle: "店铺资料",
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: defaultTargetPlatform == TargetPlatform.iOS
                ? FormKeyboardActions(child: _buildBody())
                : SingleChildScrollView(child: _buildBody()),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: MyButton(
              text: "提交",
              onPressed: () {
//                NavigatorUtil.push(context, StoreRouter.auditResultPage);
                NavigatorUtil.push(context, Routers.home, clearStack: true);

              },
            ),
          )
        ],
      )),
    );
  }

  String _sortName = "";
  var _list = [
    "水果生鲜",
    "家用电器",
    "休闲食品",
    "茶酒饮料",
    "美妆个护",
    "粮油调味",
    "家庭清洁",
    "厨具用品",
    "儿童玩具",
    "床上用品"
  ];

  _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gaps.vGap5,
          const Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text("店铺资料", style: TextStyles.textBoldDark18),
          ),
          Center(
            child: SelectedImage(image: _imageFile, onTap: _getImage),
          ),
          Gaps.vGap10,
          const Center(
            child: const Text(
              "店主手持身份证或营业执照",
              style: TextStyles.textGray14,
            ),
          ),
          Gaps.vGap16,
          TextFieldItem(
              focusNode: _nodeText1, title: "店铺名称", hintText: "填写店铺名称"),
          StoreSelectTextItem(
              title: "主营范围",
              content: _sortName,
              onTap: () {
                _showBottomSheet();
              }),
          StoreSelectTextItem(
            title: "店铺地址",
            content: _address,
            onTap: (){
              NavigatorUtil.pushResult(context, ShopRouter.addressSelectPage, (result){
                setState(() {
                  PoiSearch model = result;
                  _address = model.provinceName + " " +
                      model.cityName + " " +
                      model.adName + " " +
                      model.title;
                });
              });
            },
          ),
          Gaps.vGap16,
          Gaps.vGap16,
          const Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text("店主信息", style: TextStyles.textBoldDark18),
          ),
          TextFieldItem(
              focusNode: _nodeText2,
              title: "店主姓名",
              hintText: "填写店主姓名"
          ),
          TextFieldItem(
              focusNode: _nodeText3,
              config: _config,
              inputType: TextInputType.phone,
              title: "联系电话",
              hintText: "填写店主联系电话"
          )
        ],
      ),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 360.0,
          child: ListView.builder(
            itemExtent: 48.0,
            itemBuilder: (_, index) {
              return InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(_list[index]),
                ),
                onTap: () {
                  setState(() {
                    _sortName = _list[index];
                  });
                  NavigatorUtil.goBack(context);
                },
              );
            },
            itemCount: _list.length,
          ),
        );
      },
    );
  }
}
