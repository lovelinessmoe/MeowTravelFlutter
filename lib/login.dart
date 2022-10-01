import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:meow_travel_flutter/api/auth.dart';
import 'package:meow_travel_flutter/travel_app/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'travel_app/travel_app_theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginUser {
  String email = "";
  String password = "";
  String code = "";
  String captchaVerification = "";

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
      "code": code,
      "captchaVerification": captchaVerification,
    };
  }
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  Widget _captchaImg = Container();

  _LoginUser loginUser = _LoginUser();

  @override
  void initState() {
    super.initState();
    _getCaptcha();
  }

  @override
  Widget build(BuildContext context) {
    // _getCaptcha();

    return Container(
        color: TravelAppTheme.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: FutureBuilder<bool>(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Stack(
                  children: <Widget>[
                    loginForm(),
                  ],
                );
              }
            },
          ),
        ));
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget loginForm() {
    return Column(
      // 垂直居中
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipOval(
          child: Image.asset("assets/travel_app/logo.png",
              height: 220, width: 220, fit: BoxFit.cover),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 26, right: 26, top: 6, bottom: 8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(38.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                offset: const Offset(0, 2),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 4, bottom: 4),
                          child: TextField(
                            onChanged: (String txt) {
                              loginUser.email = txt;
                            },
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            cursorColor: HexColor('#54D3C2'),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person, color: AppTheme.grey),
                              border: InputBorder.none,
                              hintText: '邮箱',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(38.0),
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                offset: const Offset(0, 2),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 4, bottom: 4),
                          child: TextField(
                            // 密码隐藏
                            obscureText: true,
                            onChanged: (String txt) {
                              loginUser.password = txt;
                            },
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            cursorColor: HexColor('#54D3C2'),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.password, color: AppTheme.grey),
                              border: InputBorder.none,
                              hintText: '密码',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(38.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          offset: const Offset(0, 2),
                          blurRadius: 8.0),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 4, bottom: 4),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            onChanged: (String txt) {
                              loginUser.code = txt;
                            },
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            cursorColor: HexColor('#54D3C2'),
                            decoration: const InputDecoration(
                              icon: Icon(Icons.data_usage, color: AppTheme.grey),
                              border: InputBorder.none,
                              hintText: '验证码',
                            ),
                          ),
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: _getCaptcha,
                          child: SizedBox(
                            height: 50,
                            // 边框
                            // decoration: BoxDecoration(
                            //     border: Border.all(color: Colors.black, width: 2)),
                            child: _captchaImg,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () async {
                          var login = await Auth.login(loginUser.toMap());
                          final prefs = await SharedPreferences.getInstance();
                          if (login["data"] != null) {
                            final setTokenResult = await prefs.setString(
                                'userToken', login["data"]["auth"]["token"]);
                            await prefs.setString(
                                "userName", login["data"]["userName"]);
                            await prefs.setString(
                                "userId", login["data"]["userId"]);
                            await prefs.setString(
                                "avatarUrl", login["data"]["avatarUrl"]);
                            await prefs.setString(
                                "email", login["data"]["email"]);
                            if (setTokenResult) {
                              debugPrint('保存登录user成功');
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/',
                                (route) => route == null,
                              );
                              // Navigator.pop(context,"haa");
                            } else {
                              debugPrint('error, 保存登录token失败');
                            }
                          }
                        },
                        child: Container(
                          height: 58,
                          padding: const EdgeInsets.only(
                            left: 56.0,
                            right: 56.0,
                            top: 16,
                            bottom: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(38.0),
                            color: const Color(0xff132137),
                          ),
                          child: const Text(
                            "登录",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  void _getCaptcha() async {
    var res = await Auth.captcha();
    var captchaCode = res['data']['img'];
    // 不需要定义的data:image/png;BASE64,
    captchaCode = captchaCode.split(',')[1];
    Uint8List bytes = const Base64Decoder().convert(captchaCode);

    loginUser.captchaVerification = res['data']['captchaVerification'];

    setState(() {
      loginUser.code = "";

      _captchaImg = Image.memory(
        bytes,
        fit: BoxFit.contain,
      );
    });
  }
}
