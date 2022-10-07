import 'package:flutter/material.dart';
import 'package:meow_travel_flutter/travel_app/group/create_group_view.dart';
import 'package:meow_travel_flutter/travel_app/group/models/group.dart';
import 'package:meow_travel_flutter/travel_app/models/tabIcon_data.dart';
import 'package:meow_travel_flutter/travel_app/my/my_page_screen.dart';

import 'travel_app/bottom_bar_view.dart';
import 'travel_app/group/group_screen.dart';
import 'travel_app/travel_app_theme.dart';

class TravelAppHomeScreen extends StatefulWidget {
  const TravelAppHomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TravelAppHomeScreenState();
}

class _TravelAppHomeScreenState extends State<TravelAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: TravelAppTheme.background,
  );

  @override
  void initState() {
    for (var tab in tabIconsList) {
      tab.isSelected = false;
    }
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = GroupScreen(animationController: animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () async {
            Group group =  Group();
            group.groupNum = 2;
            await CreateGroupView.showCreateGroupView(context,group);
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      GroupScreen(animationController: animationController);
                });
              });
            } else if (index == 1 || index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyPageScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
