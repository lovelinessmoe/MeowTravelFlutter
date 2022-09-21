import 'package:flutter/material.dart';
import 'package:meow_travel_flutter/api/auth.dart';

import 'fitness_app/fitness_app_theme.dart';
import 'main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: FitnessAppTheme.background,
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
          child: Image.asset("assets/images/logo.png",
              height: 220, width: 220, fit: BoxFit.cover),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 26, right: 26, top: 60, bottom: 8),
          child: Column(
            children: [
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
                            onChanged: (String txt) {},
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            cursorColor: HexColor('#54D3C2'),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '用户名',
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
                            onChanged: (String txt) {},
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            cursorColor: HexColor('#54D3C2'),
                            decoration: const InputDecoration(
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
              Row(
                children: [
                  Expanded(
                      child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () {
                          Map user = {
                            "userName": "1695560542@qq.com",
                            "password": "123456"
                          };
                          // Map<String, dynamic> map = json.decode(jsonStr);
                          Auth.login(user);
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
                            "Let's begin",
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
}
