import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_public_widget/register_module/register_page.dart';
import 'package:get/get.dart';
import 'package:flutter_public_widget/flutter_public_widget.dart';

import 'seturl_page.dart';

import 'code_login_view.dart';
import 'login_logic.dart';

class LoginPage extends StatefulWidget {

  VoidCallback voidCallback;

  LoginPage(this.voidCallback);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final LoginLogic logic = Get.put(LoginLogic());

  late TabController _controller;

  var usernameTF = TextEditingController();
  var passwordTF = TextEditingController();

  bool displayPsw = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Get.to(SetUrlPage());
              })
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              // color: Colors.red,
              padding: EdgeInsets.only(top: 25, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ///gengx
                          Image.asset(
                            'images/supstar_icon.png',
                            width: 50,
                            height: 50,
                            package: 'flutter_public_widget',
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: Text(
                              '????????????APP'.tr,
                              style: TextStyle(
                                  fontSize: 22,
                                  color: HexColor('#333333'),
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      )
                      // Container(
                      //   margin: EdgeInsets.only(top: 5),
                      //   child: Text(
                      //     '??????????????????,??????',
                      //     style: TextStyle(
                      //         fontSize: 12,
                      //         color: HexColor('#999999'),
                      //         fontWeight: FontWeight.w400),
                      //   ),
                      // )
                    ],
                  ),
                  // Image.asset(A.assets_loginright)
                ],
              )),
          Expanded(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 15),
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0.0),
                    boxShadow: [
                      BoxShadow(
                          color: HexColor('#ECECEC'),
                          offset: Offset(1.0, 5.0), //??????xy????????????
                          blurRadius: 10.0, //??????????????????
                          spreadRadius: 1.0 //??????????????????
                          )
                    ]),
                child: TabBar(
                  isScrollable: true,
                  controller: _controller,
                  labelStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelStyle:
                      TextStyle(fontSize: 14, color: HexColor('567BFD')),
                  unselectedLabelColor: HexColor('#333333'),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: UnderlineTabIndicatorLi(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                          style: BorderStyle.solid)),
                  // indicatorColor: HexColor('#567BFD'),

                  tabs: [
                    Tab(
                      text: '????????????'.tr,
                    ),
                    Tab(
                      text: '???????????????'.tr,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      ListView(
                        children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                //?????????????????? ??????
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25.0)),
                                //??????????????????
                                border: Border.all(
                                    width: 1, color: HexColor('#ECECEC')),
                              ),
                              padding: const EdgeInsets.only(left: 15),
                              margin: const EdgeInsets.only(
                                  top: 20, left: 15, right: 15),
                              // width: Get.width-100,
                              child: TextField(
                                controller: usernameTF,
                                autofocus: true,
                                style: TextStyle(fontSize: 16),
                                inputFormatters: <TextInputFormatter>[
                                  LengthLimitingTextInputFormatter(13) //????????????
                                ],
                                decoration: InputDecoration(
                                  // isCollapsed: true,
                                  // contentPadding: EdgeInsets.only(top: 15),
                                  hintText: '???????????????/?????????'.tr,
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: HexColor('#BBBBBB')),
                                  border: InputBorder.none,
                                  // prefixIcon: Image.asset(A.assets_user,),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                                decoration: BoxDecoration(
//??????
                                  color: Colors.white,
                                  //?????????????????? ??????
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25.0)),
                                  //??????????????????
                                  border: Border.all(
                                      width: 1, color: Colors.grey.shade200),
                                ),
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(
                                    top: 10, right: 15, left: 15),
                                child: Row(
                                  children: [
                                    Container(
                                      width: Get.width - 100,
                                      child: TextField(
                                        obscureText: displayPsw,
                                        controller: passwordTF,
                                        style: TextStyle(fontSize: 16),
                                        inputFormatters: <TextInputFormatter>[
                                          // WhitelistingTextInputFormatter.digitsOnly,//???????????????
                                          LengthLimitingTextInputFormatter(
                                              16) //????????????
                                        ],
                                        decoration: InputDecoration(
                                          // contentPadding: EdgeInsets.only(top: 15),
                                          hintText: '???????????????'.tr,
                                          hintStyle: TextStyle(
                                              fontSize: 16,
                                              color: HexColor('#BBBBBB')),
                                          border: InputBorder.none,
                                          // prefixIcon: Image.asset(A.assets_pwd),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          displayPsw = !displayPsw;

                                          setState(() {});
                                        },
                                        icon: Image.asset(
                                          'images/showps.png',
                                          width: 15,
                                          height: 15,
                                          package: 'flutter_public_widget',
                                        ))
                                  ],
                                )),
                          ),

                          // GestureDetector(
                          //   child: Container(
                          //     padding: EdgeInsets.only(left: 25,top: 15,right: 25),
                          //     // color: Colors.red,
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //       children: [
                          //         Text('????????????'.tr,style: TextStyle(fontSize: 14,color: HexColor('#2A39E1')),),
                          //         Text('????????????'.tr,style: TextStyle(fontSize: 14,color: HexColor('#2A39E1')),),
                          //       ],
                          //     ),
                          //
                          //   ),
                          //   onTap: (){
                          //     Get.to(RegisterPage());
                          //   },
                          // ),

                          Container(
                            padding:
                                EdgeInsets.only(left: 25, top: 15, right: 25),
                            // color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  child: Text(
                                    '????????????'.tr,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  onTap: () {
                                    Get.to(RegisterPage());
                                  },
                                ),
                                // GestureDetector(
                                //
                                //   child:  Text('????????????'.tr,style: TextStyle(fontSize: 14,color: HexColor('#2A39E1')),),
                                //   onTap: (){
                                //     // Get.to(gesture_page());
                                //     Get.to(GesturePasswordWidgetDemo());
                                //   },
                                // ),
                                //  GestureDetector(
                                //
                                //    child:  Text('????????????'.tr,style: TextStyle(fontSize: 14,color: HexColor('#2A39E1')),),
                                //    onTap: (){
                                //      // Get.to(gesture_page());
                                //      Get.to(FaceLoginPage());
                                //      // Get.to(GesturePasswordWidgetDemo());
                                //    },
                                //  ),
                                GestureDetector(
                                  child: Text(
                                    '????????????'.tr,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  onTap: () {
                                    // Get.to(MyWebView(title: '????????????',url: 'https://docs.qq.com/doc/DZmFZYVVKTldOQ3dp',));
                                    Get.to(MyWebView('????????????',
                                        'https://docs.qq.com/doc/DZmFZYVVKTldOQ3dp'));
                                  },
                                )
                              ],
                            ),
                          ),

                          Container(
                            margin:
                                EdgeInsets.only(top: 62, right: 15, left: 15),
                            width: Get.width,
                            height: 45,
                            child: RaisedButton(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22),
                              ),
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                bool s =  await logic.requestDataWithLogin(usernameTF.text,passwordTF.text);

                                if(s == true){
                                  widget.voidCallback();
                                }

                                // logic.requestLoginData(logic.tf1.text, logic.tf2.text);
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              child: Text(
                                '??????'.tr,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),

                          Container(
                            // color: Colors.red,
                            margin: EdgeInsets.only(top: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '??????',
                                  style: TextStyle(
                                      fontSize: 12, color: HexColor('#333333')),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Get.to();
                                  },
                                  child: Text(
                                    '????????????????????????????????????????????????',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const CodeLoginPage(),
                      // Container(),
                    ],
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
