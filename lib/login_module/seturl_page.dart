import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_public_widget/flutter_public_widget.dart';

class SetUrlPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SetUrlPageState();
  }
}

class SetUrlPageState extends State<SetUrlPage> {
  /// http://122.51.164.176:8072
  var urltf = TextEditingController();

  late List<String> urlList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    syncInit();
  }

  void syncInit() async {

    var urlStr = await PersistentStorage().hasKey('urlStr');
    var hasurlList = await PersistentStorage().hasKey('urlList');

    if (urlStr == true) {
      urltf.text = await PersistentStorage().getStorage('urlStr');
    } else {
      // urltf.text = 'http://202.136.212.84:8069';
      // urltf.text = 'http://122.51.164.176:8072';
      urltf.text = 'http://122.51.164.176:8088';
      // prefs.setString('urlStr', '${urltf.text}');
    }

    if (hasurlList == true) {
      urlList = await PersistentStorage().getStorage('urlList');
    } else {}

    setState(() {});

    // prefs.setString('urlStr', 'http://122.51.164.176:8072');
    //
    // urltf.text = prefs.getString('urlStr');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('设置URL'),
        actions: [
          TextButton(
              onPressed: () async {
                if (urltf.text == 'http://') {
                  // Toast.toast(context,msg: '请输入正确的url');
                  BotToast.showText(text: '请输入正确的url');
                  return;
                }
                // var prefs = await SharedPreferences.getInstance();

                await PersistentStorage().setStorage('urlStr',  urltf.text);

                urlList.add(urltf.text);

                await PersistentStorage().setStorage('urlStr',  urltf.text);


                setState(() {});
                Get.back();

                DioManager().baseOptions = BaseOptions(
                    baseUrl: urltf.text
                );
                DioManager().dio.options = DioManager().baseOptions;

              },
              child: Text(
                '保存'.tr,
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 10),
              decoration: new BoxDecoration(
//背景
                color: Theme.of(context).cardColor,
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                //设置四周边框
                border: new Border.all(width: 1, color: Colors.grey.shade200),
              ),
              width: Get.width,
              child: TextField(
                autofocus: true,
                onChanged: (v) {},
                decoration: InputDecoration(border: InputBorder.none),
                controller: urltf,
                keyboardType: TextInputType.url,
                // textInputAction: TextInputAction.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              urlList.clear();
              await PersistentStorage().removeStorage('urlList');

              setState(() {});
            },
            child: Container(
                padding: EdgeInsets.only(top: 15, left: 15),
                width: Get.width,
                child: Row(
                  children: [
                    Text(
                      '历史记录',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.grey,
                      size: 20,
                    )
                  ],
                )
              // color: Colors.red,
            ),
          ),
          // Expanded(
          //     child: ListView.builder(
          //         itemCount: urlList.length,
          //         itemBuilder: (BuildContext c, int i) {
          //           return SwipeActionCell(
          //               key: ValueKey(urlList[i]),
          //               trailingActions: <SwipeAction>[
          //                 SwipeAction(
          //                     style:
          //                         TextStyle(fontSize: 12, color: Colors.white),
          //                     widthSpace: 60,
          //                     title: "删除",
          //                     onTap: (CompletionHandler handler) async {
          //                       await handler(true);
          //                       urlList.removeAt(i);
          //                       await PersistentStorage()
          //                           .setStorage('urlList', urlList);
          //                       setState(() {});
          //                     },
          //                     color: Colors.red),
          //               ],
          //               child: GestureDetector(
          //                 onTap: () async {
          //                   urltf.text = urlList[i];
          //                   await PersistentStorage()
          //                       .setStorage('urlStr', urlList[i]);
          //                   Get.back();
          //                 },
          //                 child: Container(
          //                   height: 40,
          //                   child: ListTile(
          //                     leading: Text('${urlList[i]}'),
          //                   ),
          //                 ),
          //               ));
          //         })
          //
          //     // ListView(
          //     //   padding: EdgeInsets.all(0),
          //     //   children:childStr(),
          //     // )
          //
          //     ),
        ],
      ),
    );
  }

// List<Widget> childStr() {
//   List<Widget> s = List();
//
//   for (int i = 0; i < urlList.length; i++) {
//     s.add(
//       SwipeActionCell(
//           key: ValueKey(urlList[i]),
//           trailingActions: <SwipeAction>[
//             SwipeAction(
//                 style: TextStyle(fontSize: 12, color: Colors.white),
//                 widthSpace: 60,
//                 title: "删除",
//                 onTap: (CompletionHandler handler) async {
//                   await handler(true);
//                   urlList.removeAt(i);
//                   await PersistentStorage().setStorage('urlList', urlList);
//                   setState(() {});
//                 },
//                 color: Colors.red),
//           ],
//           child: GestureDetector(
//             onTap: () async {
//               urltf.text = urlList[i];
//               await PersistentStorage().setStorage('urlStr', urlList[i]);
//               Get.back();
//             },
//             child: Container(
//               height: 40,
//               child: ListTile(
//                 leading: Text('${urlList[i]}'),
//               ),
//             ),
//           )),
//     );
//
//     //     GestureDetector(
//     //   onTap: ()async{
//     //     urltf.text = urlList[i];
//     //     await PersistentStorage().setStorage('urlStr', urlList[i]);
//     //     Get.back();
//     //   },
//     //   child: Container(
//     //     height: 40,
//     //     child: ListTile(
//     //       leading: Text('${urlList[i]}'),
//     //     ),
//     //   ),
//     // ));
//   }
//   return s;
// }
}
