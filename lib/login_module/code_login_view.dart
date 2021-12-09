import 'dart:async';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_public_widget/flutter_public_widget.dart';

import 'dart:convert';

import 'login_logic.dart';


class CodeLoginPage extends StatefulWidget {
  const CodeLoginPage({Key? key}) : super(key: key);

  @override
  _CodeLoginPageState createState() => _CodeLoginPageState();
}

class _CodeLoginPageState extends State<CodeLoginPage>
    with SingleTickerProviderStateMixin {

  final LoginLogic logic = Get.put(LoginLogic());

  var _username = TextEditingController();

  var _pwd = TextEditingController();

  var options = '+86';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Center(
            child: Container(
                decoration: new BoxDecoration(
                  // color: Colors.white,
                  //设置四周圆角 角度
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  //设置四周边框
                  border: new Border.all(
                      width: 1, color: HexColor('#DFDFDF')),
                ),
                margin: EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(

                        margin: EdgeInsets.only(left: 15),
                        width: 200,
                        child: Row(
                          children: [

                            GestureDetector(
                              onTap: () async {
                                // var data = await  Get.to(SelectOptionsPage());
                                // if(data!=null){
                                //   options = data;
                                //   setState(() {
                                //
                                //   });
                                // }

                              },
                              child: Text(
                                '${options}', style: TextStyle(color: Theme
                                  .of(context)
                                  .primaryColor),),
                            ),
                            // TextButton(onPressed: (){
                            //   Get.to(SelectOptionsPage());
                            //
                            // }, child: Text('+86')),

                            Container(
                              padding: EdgeInsets.only(left: 5),
                              width: 160,
                              child: TextField(
                                controller: _username,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(
                                    fontSize: 16, color: HexColor('#333333')),
                                decoration: InputDecoration(
                                  hintText: '请输入手机号码'.tr,
                                  hintStyle: TextStyle(fontSize: 16,
                                      color: HexColor('#BBBBBB')),
                                  border: InputBorder.none,
                                  // prefixIcon: Icon(Icons.phone_android,size: 15,),
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      width: 90,
                      child: GestureDetector(
                        child: Obx(() {
                          return Text(
                            logic.countdownTime > 0 ? '重新发送(${logic
                                .countdownTime})' : '获取验证码',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor, fontSize: 14,),
                          );
                        }),
                        onTap: () {

                          if (!GetUtils.isPhoneNumber(_username.text)) {
                            // Toast.toast(context,msg: '请输入正确的手机号码');
                            BotToast.showText(text: '请输入正确的手机号码');
                            return;
                          }
                          if(_username.text.isEmpty){
                            BotToast.showText(text: '请输入正确的手机号码');
                            return;
                          }


                          logic.startCountdownTimer();

                          logic.requestDataSendCode(_username.text).then((
                              json) {
                            BotToast.showText(text: json['message']);
                            BotToast.closeAllLoading();


                            // startCountdownTimer();
                            // if(_countdownTime== 0){
                            //
                            //   setState(() {
                            //     _countdownTime = 59;
                            //   });
                            //
                            // }

                          });
                        },
                      ),

                    )
                  ],
                )
            ),
          ),
          Center(
            child: Container(
              decoration: new BoxDecoration(
//背景
//                 color: Colors.white,
                //设置四周圆角 角度

                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                //设置四周边框
                border: new Border.all(width: 1, color: HexColor('#DFDFDF')),


              ),

              margin: EdgeInsets.only(top: 10, right: 15, left: 15),
              child: Container(
                margin: EdgeInsets.only(left: 25),
                child: TextField(

                  controller: _pwd,
                  style: TextStyle(fontSize: 16, color: HexColor('#333333')),
                  decoration: InputDecoration(
                    hintText: '请输入验证码'.tr,
                    hintStyle: TextStyle(fontSize: 16, color: HexColor(
                        '#BBBBBB')),
                    border: InputBorder.none,
                    // prefixIcon: Image.asset(A.assets_pwd),
                  ),
                ),
              ),
            ),
          ),


          Container(
            padding: EdgeInsets.only(left: 25, top: 15, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(

                  child: Text(
                    '手势登录'.tr, style: TextStyle(fontSize: 14, color: HexColor(
                      '#2A39E1')),),
                  onTap: () {
                    // Get.to(GesturePasswordWidgetDemo());
                  },
                ),
                GestureDetector(

                  child: Text(
                    '人脸登录'.tr, style: TextStyle(fontSize: 14, color: HexColor(
                      '#2A39E1')),),
                  onTap: () {
                    // Get.to(FaceLoginPage());
                  },
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 72, right: 15, left: 15),
            width: Get.width,
            height: 45,
            child: RaisedButton(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              color: Theme
                  .of(context)
                  .primaryColor,
              onPressed: () async {

                if (_username.text.isEmpty) {
                  // Toast.toast(context,msg: '请输入手机号码');
                  BotToast.showText(text: '请输入手机号码');
                  return;
                }
                if(!GetUtils.isPhoneNumber(_username.text)){
                  BotToast.showText(text: '请输入正确的手机号码');
                  return;
                }

                logic.requestDataWithCodeLogin(_username.text, _pwd.text);
              },
              child: Text('登录'.tr, style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }


}


