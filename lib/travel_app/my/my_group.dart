import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meow_travel_flutter/api/group.dart';
import 'package:meow_travel_flutter/travel_app/animate_view.dart';
import 'package:meow_travel_flutter/travel_app/group/models/group.dart';
import 'package:meow_travel_flutter/travel_app/my/models/check_group_info_entity.dart';

import '../group/create_group_view.dart';

class MyGroup extends StatefulWidget {
  const MyGroup({super.key, this.animationController, this.animation});

  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  State<StatefulWidget> createState() => _MyGroupState();
}

class _MyGroupState extends State<MyGroup> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    myGroupInfo();
  }

  Widget _myGroupInfo = Container();

  @override
  Widget build(BuildContext context) {
    return AnimateView(
        animation: widget.animation,
        animationController: widget.animationController!,
        childView: Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30),
            child: _myGroupInfo));
  }

  myGroupInfo() async {
    List<Widget> listViews = <Widget>[];

    var res = await GroupApi.getMyGroup();
    List<dynamic> data = res["data"];
    final int count = data.length;
    // 构造view
    for (int i = 0; i < count; i++) {
      Group group = Group.fromJson(data[i]);
      listViews.add(buildGroupInfoView(group));
    }
    if (count == 0) {
      listViews.add(const Text('你还没有创建旅游团哦。'));
    }

    setState(() {
      _myGroupInfo = Column(
        children: listViews,
      );
    });
  }

  buildGroupInfoView(Group group) {
    return ListTile(
      leading: AspectRatio(
          aspectRatio: 1 / 1,
          child: Image(
            image: CachedNetworkImageProvider(
              group.groupImg ??
                  "https://s2.loli.net/2022/04/05/3QmL6UklnaV9EP5.jpg",
            ),
          )),
      title: Text(group.groupName ?? ""),
      subtitle: Text(group.groupShortMsg ?? ""),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await CreateGroupView.showCreateGroupView(context, group);
              },
            ),
            IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () {
                openCheckGroupInfoDialog(group);
              },
            ),
          ],
        ),
      ),
    );
  }

  openCheckGroupInfoDialog(Group group) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

    var res = await GroupApi.getGroupCheckInfo(group.groupId ?? "");
    List<dynamic> data = res["data"];
    final int count = data.length;

    List<DataRow> checkGroupInfoList = <DataRow>[];
    for (int i = 0; i < count; i++) {
      CheckGroupInfoEntity checkGroupInfo =
          CheckGroupInfoEntity.fromJson(data[i]);
      checkGroupInfoList.add(DataRow(
        cells: <DataCell>[
          DataCell(SizedBox(
            width: 48,
            child: Image.network(checkGroupInfo.avatarUrl ?? ""),
          )),
          DataCell(Text(checkGroupInfo.userName ?? "")),
          DataCell(Text(checkGroupInfo.telephone ?? "")),
          DataCell(Text(checkGroupInfo.email ?? "")),
          DataCell(Text(checkGroupInfo.reportTime ?? "未打卡")),
          DataCell(Text(checkGroupInfo.locationLat.toString())),
          DataCell(Text(checkGroupInfo.locationLng.toString())),
          DataCell(
              Text(formatter.format(checkGroupInfo.addTime ?? DateTime.now()))),
          DataCell(TextButton(
            child: checkGroupInfo.isLeader ?? false
                ? const Text("解散旅游团")
                : const Text("踢出"),
            onPressed: () {
              GroupApi.removeUserFromGroup(
                  checkGroupInfo.userId ?? "", group.groupId ?? "");
              myGroupInfo();
            },
          )),
        ],
      ));
    }
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const <DataColumn>[
                        DataColumn(label: Text('头像')),
                        DataColumn(label: Text('用户名')),
                        DataColumn(label: Text('电话号')),
                        DataColumn(label: Text('邮箱')),
                        DataColumn(label: Text('打卡时间')),
                        DataColumn(label: Text('经度')),
                        DataColumn(label: Text('纬度')),
                        DataColumn(label: Text('入团时间')),
                        DataColumn(label: Text('操作')),
                      ],
                      rows: checkGroupInfoList,
                    )),
              ),
            ));
  }
}
