import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../travel_app_theme.dart';
import 'models/group.dart';

class GroupListView extends StatelessWidget {
  const GroupListView(
      {Key? key,
      this.groupData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final Group? groupData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image(
                                image: CachedNetworkImageProvider(
                                  groupData?.groupImg ??
                                      "https://s2.loli.net/2022/04/05/3QmL6UklnaV9EP5.jpg",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: TravelAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, top: 8, bottom: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            groupData?.groupName ?? "",
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22,
                                            ),
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                groupData?.groupShortMsg ?? "",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey
                                                        .withOpacity(0.8)),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 4),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  '创建时间: ${formatter.format(groupData?.createTime ?? DateTime.now())}',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '${groupData?.nowNum}   /   ${groupData?.groupNum}',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                        ),
                                        Text(
                                          '当前人数/最大人数',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Colors.grey.withOpacity(0.8)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        /*Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: TravelAppTheme.buildLightTheme()
                                      .primaryColor,
                                ),
                              ),
                            ),
                          ),
                        )*/
                      ],
                    ),
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
