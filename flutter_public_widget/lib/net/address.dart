



class Address{
  // static const String homeHost = 'http://222.92.131.2:1000';
  // static const String homeHost = 'http://192.168.0.32:1000';

  static const String homeHost = 'http://122.51.164.176:8088';


  static const String host = '/api/v1';

  // 登录
  static const String login = '${host}/login/0';

  // 注册
  static const String signup = '${host}/signup/0';

  ///发送验证码
  static const String sendCode = '$host/sms/0';

  /// 查寻的接口
  static const String queryData = '$host/page/0';

  // 公开接口

  static const String news = '${host}/public_getattr/0';


  /// 公共函数；
  static const String pubilc_getattr = '$host/public_getattr/0';


  //
  static const String getattt = '${host}/getattr/0';
 /// 创建
  static const String create = '${host}/create/0';

  /// 创建一个
  static const String createData = '$host/create/0';
}

