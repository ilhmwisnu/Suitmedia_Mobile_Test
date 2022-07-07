import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);
  static const routeName = "/third";

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  List userList = [];
  int page = 1;
  bool isLoading = true;
  RefreshController refreshController = RefreshController();

  @override
  void initState() {
    getUsers(page.toString()).then((value) {
      setState(() {
        isLoading = false;
        page += 1;
      });
    });

    super.initState();
  }

  void loadMore() {
    try {
      getUsers(page.toString()).then((value) {
        setState(() {});
        refreshController.loadComplete();
      });
      page += 1;
    } catch (e) {
      refreshController.loadFailed();
    }
  }

  Future<void> refresh() async {
    setState(() {
      page = 1;
      userList.clear();
    });

    await getUsers(page.toString());
    refreshController.refreshCompleted();
    setState(() {
      page += 1;
    });
  }

  Future<void> getUsers(String pageNum) async {
    try {
      final url = "https://reqres.in/api/users?page=" + pageNum;
      Uri uriUrl = Uri.parse(url);

      var res = await http.get(uriUrl);
      var data = jsonDecode(res.body)["data"];
      setState(() {
        userList.addAll(data);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.3,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              color: Color(0xff554AF0),
            ),
            onPressed: () {
              Navigator.pop(context, "");
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Third Screen",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: (isLoading)
            ? Center(child: CircularProgressIndicator())
            : SmartRefresher(
                enablePullUp: true,
                controller: refreshController,
                onRefresh: refresh,
                onLoading: loadMore,
                child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(
                              context,
                              userList[index]["first_name"] +
                                  " " +
                                  userList[index]["last_name"]);
                        },
                        child: ListTile(
                          title: Text(
                            userList[index]["first_name"] +
                                " " +
                                userList[index]["last_name"],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(userList[index]["email"]),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(userList[index]["avatar"]),
                          ),
                        ),
                      );
                    }),
              ));
  }
}
