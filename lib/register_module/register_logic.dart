import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../login_module/login_page.dart';
import '../net/Address.dart';
import '../net/persisten_storage.dart';
import '../net/dio_manager.dart';
import 'package:bot_toast/bot_toast.dart';

class RegisterLogic extends GetxController{


  late Timer timer;

  var countdownTime = 0.obs;

  @override
  void onClose() {
    timer.cancel();
    // TODO: implement onClose
    super.onClose();
  }


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


  Future requestDataSendCode(var tf)async{
    var params = {
      'mobile':tf,
      'name':'登录确认验证码',
      'type':'0',
    };
    // String result = await DioManager(url: await PersistentStorage().getStorage('urlStr')).post(Address.sendCode,data:params);

    var result  = await DioManager().postModel(Address.sendCode,params: params);
    return result;

  }

  /*
  * 注册账号
  * */
  void requestDataWithSetPass(var name,var mobile,var password,var verifyCode)async{
    var params = {
      // 'project_name':tf3.text,
      // 'company_name':tf4.text,

      'name':name,
      'mobile':mobile,
      'password':password,
      'verifyCode':verifyCode,
      'boosapp':'是',

    };

    // String  result = await DioUtils(url: await PersistentStorage().getStorage('urlStr')).post(Address.signup,data:params);
    var json = await DioManager().postModel(Address.signup,params: params);

    BotToast.showText(text: json['message']);

    Get.offAll(LoginPage(() { }));

  }

}