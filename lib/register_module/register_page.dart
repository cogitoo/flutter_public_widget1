import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../common_widget/hexcolor.dart';
import '../register_module/register_getcode_page.dart';
import '../register_module/register_logic.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {


  // final LoginLogic logic = Get.put(LoginLogic());


  RegisterLogic logic = Get.put(RegisterLogic());

  var tf = TextEditingController();

  var strMobile = '';

  @override
  void initState() {
    super.initState();



  }

  @override
  void dispose() {
    super.dispose();
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
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20,left: 20),
            child: Text('注册'.tr,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
          ),
          Container(
            margin: EdgeInsets.only(top: 5,left: 20),
            child: Text('未注册的手机号验证后自动注册'.tr,style: TextStyle(fontSize: 12,color: HexColor('#999999')),),
          ),


          Container(
            margin: EdgeInsets.only(left: 20,top: 50),
            child: TextField(

              onChanged: (text){
                strMobile = text;
                // String phoneNo = TextUtil.formatSpace4("${text}"); // 1584 5678 910
                tf.text = text;
                tf.selection =
                    TextSelection.fromPosition(
                        TextPosition(offset: tf.text.length));
              },


              autofocus: true,
              keyboardType: TextInputType.phone,
              controller: tf,
                 inputFormatters: <TextInputFormatter>[
                 WhitelistingTextInputFormatter.digitsOnly,//只输入数字
                   LengthLimitingTextInputFormatter(11)//限制长度
                ],
              style: TextStyle(
                fontSize: 24,
                color: HexColor('333333')
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 24,color: HexColor('#CCCCCC')),
                hintText: '请输入手机号码'.tr,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50,right: 25,left: 25),
            width: Get.width,
            height: 45,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              color:Theme.of(context).primaryColor,
              onPressed: ()async{
                if(tf.text.isEmpty){
                  // Toast.toast(Get.overlayContext,msg: '请输入正确的手机号码');
                  BotToast.showText(text: '请输入手机号码');

                  return;
                }
                if(!GetUtils.isPhoneNumber(strMobile)){
                    BotToast.showText(text: '请输入正确的手机号码');
                    return;
                }
                // if(!RegexUtil.isMobileSimple(strMobile)){
                //   BotToast.showText(text: '请输入正确的手机号码');
                //   return;
                // }

                // Get.to(RegisterGetCodePage(strMobile));

                logic.requestDataSendCode(tf.text.replaceAll(new RegExp(r"\s+\b|\b\s"), "")).then((value) {
                  if(value['errcode'] == 0){

                    BotToast.showText(text: value['message']);
                    Get.to(RegisterGetCodePage(strMobile));
                  }
                });


                // Get.to(RegisterGetCodePage(tf.text));
                //
                // logic.requestDataSendCode(tf.text).then((value) {
                //   if(value['errocode']==0){
                //     Get.to(RegisterGetCodePage(tf.text));
                //   }
                // });
              },
              child: Text('获取验证码'.tr,style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }


}
