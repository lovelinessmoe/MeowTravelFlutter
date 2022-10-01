import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meow_travel_flutter/api/group.dart';
import 'package:meow_travel_flutter/api/upYun.dart';
import 'package:meow_travel_flutter/travel_app/app_theme.dart';
import 'package:meow_travel_flutter/travel_app/group/models/group.dart';
import 'package:uuid/uuid.dart';

import '../travel_app_theme.dart';

class CreateGroupView extends StatefulWidget {
  const CreateGroupView({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  State<StatefulWidget> createState() => _CreateGroupViewState();
}

class _CreateGroupViewState extends State<CreateGroupView>
    with TickerProviderStateMixin {
  Group group = Group();

  //实例化选择图片
  final ImagePicker picker = ImagePicker();

  //用户本地图片
  File? _userImage; //存放获取到的本地路径

  Map<String, dynamic>? groupInfo = {};

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: TravelAppTheme.background,
      child: Scaffold(
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 图片
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("添加旅游团图片"),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: InkWell(
                            splashColor: Colors.white.withOpacity(0.1),
                            highlightColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            onTap: () {
                              _getImage();
                            },
                            child: _userImage == null
                                ? const Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 100,
                                    color: AppTheme.lightText,
                                  )
                                : Image.file(
                                    _userImage!,
                                    height: 100,
                                  )),
                      ),
                    ),
                  ],
                ),
                // 名称
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("旅游团名称"),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        onChanged: (String txt) {
                          group.groupName = txt;
                          // groupInfo?.putIfAbsent("groupName", () => txt);
                        },
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        cursorColor: AppTheme.darkText,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: '请输入名称',
                        ),
                      ),
                    ),
                  ],
                ),
                // 简介
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("旅游团介绍"),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        maxLines: 3,
                        onChanged: (String txt) {
                          group.groupShortMsg = txt;
                          // groupInfo?.putIfAbsent("groupShortMsg", () => txt);
                        },
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        cursorColor: AppTheme.darkText,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          hintText: '请输入简介',
                        ),
                      ),
                    ),
                  ],
                ),
                // 是否开启健康打卡
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("是否开启健康打卡"),
                      ),
                    ),
                    Expanded(
                      child: Switch(
                        dragStartBehavior: DragStartBehavior.down,
                        key: UniqueKey(),
                        value: group.isOpenReport ?? false,
                        onChanged: (bool newValue) {
                          setState(() => group.isOpenReport = newValue);
                        },
                      ),
                    ),
                  ],
                ),
                // 旅游团最大人数
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text("旅游团最大人数"),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                      onChanged: (String txt) {
                        group.groupNum = int.parse(txt);
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                      ],
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      cursorColor: AppTheme.darkText,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: '请输入最大人数',
                      ),
                    )),
                  ],
                ),
                // 确定
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: FloatingActionButton(
                          mini: true,
                          child: const Icon(
                            Icons.save,
                            color: Colors.white,
                            size: 18,
                          ),
                          onPressed: () {
                            GroupApi.saveOrUpdateGroup(group.toJson());
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //选择相册
  _getImage() async {
    final pickerImages = await picker.pickImage(source: ImageSource.gallery);
    if (mounted) {
      if (pickerImages != null) {
        setState(() {
          _userImage = File(pickerImages.path);
        });
        var res = await _upLoadImage(_userImage!);
        group.groupImg = res["data"];
        // groupInfo?.putIfAbsent("groupImg", () => res["data"]);
      } else {
        Fluttertoast.showToast(
            msg: '没有照片选择',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  _upLoadImage(File image) async {
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
    var uuid = const Uuid();
    String uri = "/Travel/group/${uuid.v4()}.$suffix";

    return await UpYun.upLoadFile(uri, path, name);
  }
}
