import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../common_widget/hexcolor.dart';
import '../register_module/register_logic.dart';
class RegisterSetPasswordPage extends StatefulWidget {


  var login;
  var verifyCode;

  RegisterSetPasswordPage(this.login,this.verifyCode);


  @override
  _RegisterSetPasswordPageState createState() => _RegisterSetPasswordPageState();
}

class _RegisterSetPasswordPageState extends State<RegisterSetPasswordPage> with SingleTickerProviderStateMixin {




  RegisterLogic logic = Get.put(RegisterLogic());

  var tf1 = TextEditingController();
  var tf2 = TextEditingController();


  var showps1 = true;
  var showps2 = true;



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
            margin: EdgeInsets.only(top: 10,left: 15),
            child: Text('设置登录密码'.tr,style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),

          ),

          Container(
            margin: EdgeInsets.only(top: 10,left: 20),
            child: Column(
              children: [
                // TextField(
                //   controller: tf3,
                //   obscureText : false,
                //
                //   style: TextStyle(fontSize: 24,color: HexColor('#242A36')),
                //   decoration: InputDecoration(
                //
                //       hintStyle: TextStyle(fontSize: 24,color: HexColor('#CCCCCC')),
                //       border: InputBorder.none,
                //       hintText: '项目名称'
                //   ),
                // ),
                // Container(height: 1,color: HexColor('#EEEEEE'),margin: EdgeInsets.only(right: 15),),
                //
                // TextField(
                //   controller: tf4,
                //   obscureText : false,
                //
                //   style: TextStyle(fontSize: 24,color: HexColor('#242A36')),
                //   decoration: InputDecoration(
                //
                //       hintStyle: TextStyle(fontSize: 24,color: HexColor('#CCCCCC')),
                //       border: InputBorder.none,
                //       hintText: '单位名称'
                //   ),
                // ),
                // Container(height: 1,color: HexColor('#EEEEEE'),margin: EdgeInsets.only(right: 15),),

                Container(

                  child: Row(
                    children: [
                      Container(
                        width: Get.width-100,
                        child: TextField(
                          controller: tf1,
                          obscureText : showps1,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp(
                                "[a-zA-Z]|[0-9]")),
                            LengthLimitingTextInputFormatter(16)
                          ],
                          style: TextStyle(fontSize: 24,color: HexColor('#242A36')),
                          decoration: InputDecoration(

                              hintStyle: TextStyle(fontSize: 24,color: HexColor('#CCCCCC')),
                              border: InputBorder.none,
                              hintText: '8-16位密码'.tr
                          ),
                        ),
                      ),
                      IconButton(onPressed: (){

                        showps1=!showps1;
                        setState(() {

                        });
                      }, icon: Image.asset('assets/showps.png')),
                    ],
                  ),
                ),
                Container(height: 1,color: HexColor('#EEEEEE'),margin: EdgeInsets.only(right: 15),),

                Container(
                  margin: EdgeInsets.only(top: 15),
                  child:Row(
                    children: [
                      Container(
                        width: Get.width-100,
                        child: TextField(
                          controller: tf2,
                          obscureText : showps2,
                          inputFormatters: [
                            WhitelistingTextInputFormatter(RegExp(
                                "[a-zA-Z]|[0-9]")),
                            LengthLimitingTextInputFormatter(16)
                          ],
                          style: TextStyle(fontSize: 24,color: HexColor('#242A36')),
                          decoration: InputDecoration(

                              hintStyle: TextStyle(fontSize: 24,color: HexColor('#CCCCCC')),
                              border: InputBorder.none,
                              hintText: '确认密码'.tr
                          ),
                        ),
                      ),
                      IconButton(onPressed: (){

                        showps2=!showps2;
                        setState(() {

                        });
                      }, icon: Image.asset('assets/showps.png')),
                    ],
                  )
                ),
                Container(height: 1,color: HexColor('#EEEEEE'),margin: EdgeInsets.only(right: 15),),

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
                      if(tf1.text.isEmpty){
                        // Toast.toast(Get.overlayContext,msg: '请输入密码');
                        BotToast.showText(text: '请输入密码');
                        return;
                      }
                      if(tf1.text!=tf2.text){
                        // Toast.toast(Get.overlayContext,msg: '请输入密码');
                        BotToast.showText(text: '两次密码不一样');
                        return;
                      }

                      logic.requestDataWithSetPass(widget.login,widget.login,tf1.text,widget.verifyCode);

                      // logic.requestDataSendCode(tf.text).then((value) {
                      //   if(value['errocode']==0){
                      //     Get.to(RegisterGetCodePage(tf.text));
                      //   }
                      // });
                    },
                    child: Text('确定'.tr,style: TextStyle(color: Colors.white),),
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }


}
