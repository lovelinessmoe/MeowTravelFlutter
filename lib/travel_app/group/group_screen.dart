import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:meow_travel_flutter/api/group.dart';
import 'package:meow_travel_flutter/travel_app/group/title_view.dart';
import 'package:meow_travel_flutter/travel_app/travel_app_theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'group_list_view.dart';
import 'models/group.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  State<StatefulWidget> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final int _size = 5;
  int _current = 1;
  bool _onlyShowJoin = false;
  BaiduLocation location = BaiduLocation();
  final LocationFlutterPlugin _myLocPlugin = LocationFlutterPlugin();

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn)));

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });

    getInitGroupList();

    getLocation();
    super.initState();
  }

  getInitGroupList() async {
    listViews.add(
      TitleView(
        titleTxt: _onlyShowJoin ? "我参加的旅游团列表" : "所有旅行团列表",
        subTxt: _onlyShowJoin ? "查看所有的" : "查看我参加的",
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval(0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
        callback: () async {
          _onlyShowJoin = !_onlyShowJoin;
          _onRefresh();
        },
      ),
    );

    // 请求初始数据
    var res = await GroupApi.getPageGroup(_current, _size, _onlyShowJoin);
    List<dynamic> data = res["data"];
    final int count = data.length;
    setState(() {
      // 构造view
      for (int i = 0; i < count; i++) {
        Group group = Group.fromJson(data[i]);
        listViews.add(buildGroupView(listViews.length + 1, group));
      }
      widget.animationController?.forward();
    });
    if (mounted) setState(() {});
  }

  Widget buildGroupView(i, Group group) {
    final Animation<double> animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController!,
        curve: Interval(i * 0.1, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    return GroupListView(
      callback: () async {
        if (_onlyShowJoin) {
          // 只看我的，点击就是打卡
          GroupApi.checkDaily(group.groupId!, location);
        } else {
          // 全部旅游团 点击就是入团
          bool? result = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("确定加入该旅游团？"),
                  actions: [
                    TextButton(
                      child: const Text("我才不参加呢"),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    ),
                    TextButton(
                        child: const Text("我要参加"),
                        onPressed: () {
                          Navigator.pop(context, true);
                        })
                  ],
                );
              });

          if (result ?? false) {
            await GroupApi.joinGroup(group.groupId ?? "");
            _onRefresh();
          }
        }
      },
      groupData: group,
      animation: animation,
      animationController: widget.animationController!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TravelAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainView(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  // topBar的后背景
                  decoration: BoxDecoration(
                    color: TravelAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: TravelAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '旅游团',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: TravelAppTheme.fontName,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 22 + 6 - 6 * topBarOpacity,
                                      letterSpacing: 1.2,
                                      color: TravelAppTheme.darkerText,
                                    ),
                                  ),
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
            );
          },
        )
      ],
    );
  }

  Widget getMainView() {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        scrollController: scrollController,
        controller: _refreshController,
        onLoading: _onLoading,
        onRefresh: _onRefresh,
        child: ListView.builder(
          padding: EdgeInsets.only(
            top: AppBar().preferredSize.height +
                MediaQuery.of(context).padding.top +
                24,
            bottom: 62 + MediaQuery.of(context).padding.bottom,
          ),
          itemCount: listViews.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            widget.animationController?.forward();
            return listViews[index];
          },
        ));
  }

  void _onRefresh() async {
    listViews.clear();
    _current = 1;
    getInitGroupList();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _current++;
    var res = await GroupApi.getPageGroup(_current, _size, _onlyShowJoin);
    List<dynamic> data = res["data"];
    final int count = data.length;
    for (int i = 0; i < count; i++) {
      Group group = Group.fromJson(data[i]);
      listViews.add(buildGroupView(listViews.length + 1, group));
    }
    widget.animationController?.forward();
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  BaiduLocationIOSOption initIOSOptions() {
    BaiduLocationIOSOption options = BaiduLocationIOSOption(
      // 坐标系
      coordType: BMFLocationCoordType.bd09ll,
      // 位置获取超时时间
      locationTimeout: 10,
      // 获取地址信息超时时间
      reGeocodeTimeout: 10,
      // 应用位置类型 默认为automotiveNavigation
      activityType: BMFActivityType.automotiveNavigation,
      // 设置预期精度参数 默认为best
      desiredAccuracy: BMFDesiredAccuracy.best,
      // 是否需要最新版本rgc数据
      isNeedNewVersionRgc: true,
      // 指定定位是否会被系统自动暂停
      pausesLocationUpdatesAutomatically: false,
      // 指定是否允许后台定位,
      // 允许的话是可以进行后台定位的，但需要项目配置允许后台定位，否则会报错，具体参考开发文档
      allowsBackgroundLocationUpdates: true,
      // 设定定位的最小更新距离
      distanceFilter: 10,
    );
    return options;
  }

  BaiduLocationAndroidOption initAndroidOptions() {
    BaiduLocationAndroidOption options = BaiduLocationAndroidOption(
        // 定位模式，可选的模式有高精度、仅设备、仅网络。默认为高精度模式
        locationMode: BMFLocationMode.hightAccuracy,
        // 是否需要返回地址信息
        isNeedAddress: true,
        // 是否需要返回海拔高度信息
        isNeedAltitude: true,
        // 是否需要返回周边poi信息
        isNeedLocationPoiList: true,
        // 是否需要返回新版本rgc信息
        isNeedNewVersionRgc: true,
        // 是否需要返回位置描述信息
        isNeedLocationDescribe: true,
        // 是否使用gps
        openGps: true,
        // 可选，设置场景定位参数，包括签到场景、运动场景、出行场景
        locationPurpose: BMFLocationPurpose.sport,
        // 坐标系
        coordType: BMFLocationCoordType.bd09ll,
        // 设置发起定位请求的间隔，int类型，单位ms
        // 如果设置为0，则代表单次定位，即仅定位一次，默认为0
        scanspan: 0);
    return options;
  }

  getLocation() async {
    Map androidMap = initAndroidOptions().getMap();
    Map iosMap = initIOSOptions().getMap();
    await _myLocPlugin.prepareLoc(androidMap, iosMap);

    if (Platform.isIOS) {
      await _myLocPlugin
          .singleLocation({'isReGeocode': true, 'isNetworkState': true});
    } else if (Platform.isAndroid) {
      await _myLocPlugin.startLocation();
    }
    if (Platform.isIOS) {
      //接受定位回调
      _myLocPlugin.singleLocationCallback(callback: (BaiduLocation result) {
        //result为定位结果
      });
    } else if (Platform.isAndroid) {
      //接受定位回调
      _myLocPlugin.seriesLocationCallback(callback: (BaiduLocation result) {
        //result为定位结果
        location = result;
      });
    }
  }
}
