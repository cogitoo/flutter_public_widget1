import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';
import '../common_widget/hexcolor.dart';
import 'register_setpassword_page.dart';
import 'package:flutter_verification_box/verification_box.dart';
import 'register_logic.dart';

class RegisterGetCodePage extends StatefulWidget {

  var phoneStr;

  RegisterGetCodePage(this.phoneStr);

  @override
  _RegisterGetCodePageState createState() => _RegisterGetCodePageState();
}

class _RegisterGetCodePageState extends State<RegisterGetCodePage>
    with SingleTickerProviderStateMixin {


  RegisterLogic logic = Get.put(RegisterLogic());


  @override
  void initState() {
    super.initState();
    logic.startCountdownTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: new IconButton(
        //   icon: Image.asset(A.assets_arrback_icon),
        //   onPressed: () => {
        //     Navigator.of(context).pop('刷新')
        //   },
        // ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 20),
            child: Text('获取验证码'.tr, style: TextStyle(fontSize: 24,
                color: HexColor('#333333'),
                fontWeight: FontWeight.w500),),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20),
            child: Text('验证码已经发送给到您的手机'.tr,
              style: TextStyle(fontSize: 12, color: HexColor('#999999')),),
          ),
          Container(
            margin: EdgeInsets.only(top: 5, left: 20),
            child: Text('+86 ${widget.phoneStr}',
              style: TextStyle(fontSize: 12, color: HexColor('#999999')),),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50, left: 25),
                  child: Text('6位数验证码'.tr, style: TextStyle(
                      fontSize: 12, color: HexColor('#999999')),),
                ),

                Container(
                  margin: EdgeInsets.only(top: 50, left: 25, right: 25),
                  child: GestureDetector(
                    child: Obx(() {
                      return Text(
                        logic.countdownTime > 0
                            ? '重新发送(${logic.countdownTime})'
                            : '获取验证码'.tr,
                        style: TextStyle(color: Theme
                            .of(context)
                            .primaryColor, fontSize: 12,),
                      );
                    }),
                    onTap: () {
                      logic.requestDataSendCode(widget.phoneStr).then((value) {
                        if (value['errcode'] == 0) {
                          logic.countdownTime.value = 59;
                          BotToast.showText(text: value['message']);
                        }
                      });
                    },
                  ),

                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            height: 45,
            child: VerificationBox(
              onSubmitted: (value) {
                print('${value}');
                Get.to(RegisterSetPasswordPage(widget.phoneStr, value));
              },
              focusBorderColor: Theme
                  .of(context)
                  .primaryColor,
              showCursor: true,
              textStyle: TextStyle(fontSize: 28, color: HexColor('#242A36')),
              borderColor: HexColor('#D2D6DC'),
              borderWidth: 1,
            ),
          )
        ],
      ),
    );
  }

}