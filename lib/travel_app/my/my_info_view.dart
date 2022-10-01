import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meow_travel_flutter/main.dart';
import 'package:meow_travel_flutter/travel_app/app_theme.dart';

import '../models/user.dart';
import '../travel_app_theme.dart';

class MyInfoView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;
  final User user;

  const MyInfoView(
      {Key? key, this.animationController, this.animation, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 16, bottom: 18),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    TravelAppTheme.nearlyDarkBlue,
                    HexColor("#6F56E8")
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(68.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: TravelAppTheme.grey.withOpacity(0.6),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          user.userName ?? "未登录",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontFamily: TravelAppTheme.fontName,
                            fontWeight: FontWeight.normal,
                            fontSize: 27,
                            letterSpacing: 0.0,
                            color: TravelAppTheme.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          user.email ?? "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            color: AppTheme.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: TravelAppTheme.nearlyWhite,
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: TravelAppTheme.nearlyBlack
                                          .withOpacity(0.4),
                                      offset: const Offset(8.0, 8.0),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Visibility(
                                // 设置是否可见：true:可见 false:不可见
                                visible: user.userToken?.isEmpty ?? true,
                                // visible: true,
                                replacement: ClipOval(
                                  child: Image(
                                    height: 48,
                                    width: 48,
                                    fit: BoxFit.cover,
                                    image: CachedNetworkImageProvider(
                                      user.avatarUrl ??
                                          "https://s2.loli.net/2022/04/05/3QmL6UklnaV9EP5.jpg",
                                    ),
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.login,
                                    color: AppTheme.grey,
                                  ),
                                  onPressed: () {
                                    // 路由跳转
                                    Navigator.of(context)
                                        .pushNamed('router/login');
                                    // .then((value) => print(value));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
