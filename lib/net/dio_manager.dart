import 'dart:convert';

import 'package:dio/dio.dart';
import '../net/persisten_storage.dart';
import 'address.dart';
import 'package:get/route_manager.dart';
import 'package:bot_toast/bot_toast.dart';
class DioManager{

  static final DioManager _instance = DioManager._internal();

  factory DioManager()=>_instance;

  DioManager._internal(){

    init();
  }
  late Dio dio;

  late BaseOptions baseOptions;

  // 初始化请求配置
  init(){
     baseOptions = BaseOptions(
       // contentType: Headers.formUrlEncodedContentType,
      baseUrl: Address.homeHost,
      connectTimeout: 5000,
    );
    dio = Dio(baseOptions);
  }

  // 请求(默认post)
  Future rcRequset(String url,{String method = "post", var params}) async{

    Options options = Options(method: method,contentType:Headers.formUrlEncodedContentType);

    BotToast.showLoading(allowClick: true,clickClose: true);

    print('请求地址 ==== ${baseOptions.baseUrl}${url} 请求参数===== ${params}');

    try{
      final result = await dio.request(url,queryParameters: params,options: options);

      print('请求结果===== result.data ======= ${result.data}');

      var json = jsonDecode(result.data);

      BotToast.closeAllLoading();


      return json;

    } on DioError catch(error){

      BotToast.closeAllLoading();

      print('请求失败---错误类型${error.type}--错误信息${error.message}');

      throw error;
    }
  }

  // post请求（基于需要传token）
  postModel(url,{var params,var model,var function_name})async{

    print('请求地址 ------${baseOptions.baseUrl}${url}   请求参数${params}');

    var publicParams = {
      'access_token':await PersistentStorage().getStorage('acctoken'),
      'uid':await PersistentStorage().getStorage('uid'),
      'partner_id':await PersistentStorage().getStorage('partner_id'),
      'model': model,
      'function_name': function_name,               // #用户接口名称
    };

    baseOptions.queryParameters = publicParams;

    try{
      final result = await dio.post(url,queryParameters: params,
          options: Options(contentType:  Headers.formUrlEncodedContentType));

      print('请求结果===== result.data ======= ${result.data}');


      var json = jsonDecode(result.data);

      BotToast.closeAllLoading();


      return json;
    }on DioError catch(e){
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        print(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.requestOptions);
        print(e.message);
      }
    }


    /// 公共擦参数
    // baseOptions.queryParameters = comParams;

    // Options options = Options(method: "post");
    //
    // final result = await dio.request(url,data: comParams,options: options);
    //
    // var json = jsonDecode(result.data);
    //
    // BotToast.closeAllLoading();
    //
    // return json;

  }

}