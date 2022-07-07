import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:suitmedia_mobile_test/const.dart';
import 'package:suitmedia_mobile_test/page/third_page.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);
  static const routeName = "/second";

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String name = "";
  bool isInit = false;
  String user = "";

  @override
  void didChangeDependencies() {
    if (!isInit) {
      setState(() {
        name = ModalRoute.of(context)!.settings.arguments as String;
      });
    }
    super.didChangeDependencies();
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
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Second Screen",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome"),
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: Center(
                child: Text(
                  (user == "") ? "Selected User Name" : user,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () async {
                      var userData = await Navigator.pushNamed(
                          context, ThirdPage.routeName);
                      setState(() {
                        user = (userData != null) ? userData as String : "";
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text("Choose a User"),
                    ),
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(primaryColor),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)))),
                  ))
                ],
              )
            ],
          ),
        ));
  }
}
