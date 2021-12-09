// import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:get/route_manager.dart';
import 'dart:async';
// import '../home_moudle/home_page.dart';
import 'package:flutter_public_widget/flutter_public_widget.dart';
class LoginLogic extends GetxController{


  late Timer timer;

  var countdownTime = 0.obs;

  late Rx<User> model;

  /// 倒计时
  ///
  void startCountdownTimer() {

    countdownTime.value = 59;

    const oneSec = const Duration(seconds: 1);

    var callback = (timer) => {
      if (countdownTime < 1)
        {timer.cancel()}
      else
        {countdownTime = countdownTime - 1}
    };

    timer = Timer.periodic(oneSec, callback);

  }

  /// 发送验证码点击
  void sendCodeClick() {
    if (countdownTime.value == 0) {
      countdownTime.value = 59;
      startCountdownTimer();
    }
  }


  ///发送验证码;

  requestDataSendCode(var phoneStr){
    var params = FormData.fromMap({
      'mobile': phoneStr,
      'type': '2',
    });
    DioManager().rcRequset('/api/v1/login/0',params:params).then((value){

      BotToast.showText(text: '${value['message']}');

    });
  }

  /// 验证码登录
  void requestDataWithCodeLogin(var username,var pwd)async{


    var params = FormData.fromMap({
      'mobile':username,
      'type':'1',
      'verifyCode':pwd
    });

    DioManager().rcRequset(Address.login,params:params).then((value){

      BotToast.showText(text: '${value['message']}');

    });

  }


  /// 账号密码登录
  requestDataWithLogin(var username, var pass)async{



    var params = {
      'login': username,
      'password': pass,
      'type': '0',
    };

    DioManager().rcRequset(Address.login,params:params).then((value) async {

      BotToast.showText(text: '${value['message']}');

      model = User.fromJson(value).obs;

      await PersistentStorage()
          .setStorage('acctoken', model.value.data.accessToken);
      await PersistentStorage().setStorage('login', model.value.data.login);
      await PersistentStorage().setStorage('uid', model.value.data.uid);
      await PersistentStorage()
          .setStorage('partner_id', model.value.data.partnerId);
      await PersistentStorage().setStorage('image128', model.value.data.image128);
      await PersistentStorage().setStorage('name', model.value.data.name);
      await PersistentStorage()
          .setStorage('is_gesture', model.value.data.is_gesture);
      Get.snackbar('提示', model.value.message, colorText: Colors.white);

      // Get.offAll(WorkBenchPage());

    });
  }


  ///
}

class User {
 late int errcode;
 late String errmsg;
 late Data data;
 late String message;

  User({required this.errcode, required this.errmsg, required this.data, required this.message});

  User.fromJson(Map<String, dynamic> json) {
    errcode = json['errcode'];
    errmsg = json['errmsg'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errcode'] = this.errcode;
    data['errmsg'] = this.errmsg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  late var locationCompanyId;
  late var locationCompanyIdName;
  late String accountType;
  late String accessToken;
  late String login;
  late String name;
  late String lang;
  late  String tz;
  late int expiresIn;
  late int uid;
  late  int partnerId;
  late int companyId;
  late String companyIdName;
  late List<int> companyIds;
  late String companyIdsName;
  late String image128;
  late String db;
  late String isConfirm;
  late  var jobUserId;
  late var jobCompanyId;
  late var mobile;
  late bool is_gesture;

  Data(
      {required this.locationCompanyId,
        required this.locationCompanyIdName,
        required this.accountType,
        required this.accessToken,
        required this.login,
        required this.name,
        required this.lang,
        required this.tz,
        required this.expiresIn,
        required this.uid,
        required this.partnerId,
        required this.companyId,
        required this.companyIdName,
        required this.companyIds,
        required this.companyIdsName,
        required this.image128,
        required this.db,
        required this.isConfirm,
        required this.jobUserId,
        required this.mobile,
        required this.is_gesture,
        required this.jobCompanyId});

  Data.fromJson(Map<String, dynamic> json) {
    locationCompanyId = json['location_company_id'];
    locationCompanyIdName = json['location_company_id_name'];
    accessToken = json['access_token'];
    login = json['login'];
    name = json['name'];
    lang = json['lang'];
    tz = json['tz'];
    expiresIn = json['expires_in'];
    uid = json['uid'];
    partnerId = json['partner_id'];
    companyId = json['company_id'];
    companyIdName = json['company_id_name'];
    companyIds = json['company_ids'].cast<int>();
    companyIdsName = json['company_ids_name'];
    image128 = json['image_128'];
    db = json['db'];
    jobUserId = json['job_user_id'];
    jobCompanyId = json['job_company_id'];
    mobile = json['mobile'];
    is_gesture = json['is_gesture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_company_id'] = this.locationCompanyId;
    data['location_company_id_name'] = this.locationCompanyIdName;
    data['account_type'] = this.accountType;
    data['access_token'] = this.accessToken;
    data['login'] = this.login;
    data['name'] = this.name;
    data['lang'] = this.lang;
    data['tz'] = this.tz;
    data['expires_in'] = this.expiresIn;
    data['uid'] = this.uid;
    data['partner_id'] = this.partnerId;
    data['company_id'] = this.companyId;
    data['company_id_name'] = this.companyIdName;
    data['company_ids'] = this.companyIds;
    data['company_ids_name'] = this.companyIdsName;
    data['image_128'] = this.image128;
    data['db'] = this.db;
    data['is_confirm'] = this.isConfirm;
    data['job_user_id'] = this.jobUserId;
    data['job_company_id'] = this.jobCompanyId;
    return data;
  }

}

