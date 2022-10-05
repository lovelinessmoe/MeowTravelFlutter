import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart'
    show BMFLog, BMFMapSDK, BMF_COORD_TYPE;
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:meow_travel_flutter/travel_app_home_screen.dart';
import 'package:meow_travel_flutter/utils/router_now.dart';
import 'package:permission_handler/permission_handler.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LocationFlutterPlugin _myLocPlugin = LocationFlutterPlugin();

    /// 动态申请定位权限
    requestPermission();

    /// 设置是否隐私政策
    /// 隐私政策官网链接：https://lbsyun.baidu.com/index.php?title=openprivacy
    /// 通知用户之后根据用户选择进行赋值
    _myLocPlugin.setAgreePrivacy(true);
    BMFMapSDK.setAgreePrivacy(true);

    if (Platform.isIOS) {
      /// 设置ios端ak, android端ak可以直接在清单文件中配置
      // myLocPlugin.authAK('请输入您的ak');
      // BMFMapSDK.setApiKeyAndCoordType('请输入您的ak', BMF_COORD_TYPE.BD09LL);
    } else if (Platform.isAndroid) {
      // Android 目前不支持接口设置Apikey,
      // 请在主工程的Manifest文件里设置，详细配置方法请参考官网(https://lbsyun.baidu.com/)demo
      BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
    }

    _myLocPlugin.getApiKeyCallback(callback: (String result) {
      String str = result;
      print('鉴权结果：' + str);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: RouterNow.navigatorKey,
      home: const TravelAppHomeScreen(),
      routes: <String, WidgetBuilder>{'router/login': (_) => const Login()},
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}

// 动态申请定位权限
void requestPermission() async {
  // 申请权限
  bool hasLocationPermission = await requestLocationPermission();
  if (hasLocationPermission) {
    // 权限申请通过
  } else {}
}

/// 申请定位权限
/// 授予定位权限返回true， 否则返回false
Future<bool> requestLocationPermission() async {
  //获取当前的权限
  var status = await Permission.location.status;
  if (status == PermissionStatus.granted) {
    //已经授权
    return true;
  } else {
    //未授权则发起一次申请
    status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}
