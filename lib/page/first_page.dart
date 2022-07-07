import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:suitmedia_mobile_test/const.dart';
import 'package:suitmedia_mobile_test/page/second_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);
  static const routeName = "/first";

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool isPalindrome(String string) {
    var temp = "";
    for (var i = 0; i < string.length; i++) {
      temp = string[i] + temp;
    }

    if (string == temp) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController palController = TextEditingController();
    FocusNode namaFocus = FocusNode();
    FocusNode palFocus = FocusNode();
    return Scaffold(
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            namaFocus.unfocus();
            palFocus.unfocus();
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background 1.png"),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage("assets/ic_photo.png")),
                    SizedBox(height: 64),
                    TextField(
                      focusNode: namaFocus,
                      controller: nameController,
                      decoration: inputStyle.copyWith(hintText: "Nama"),
                    ),
                    SizedBox(height: 24),
                    TextField(
                        focusNode: palFocus,
                        controller: palController,
                        decoration:
                            inputStyle.copyWith(hintText: "Palindrome")),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            var msg = "";
                            if (isPalindrome(palController.text)) {
                              msg = "isPalindrome";
                            } else {
                              msg = "not palindrome";
                            }
                            var snackBar = SnackBar(content: Text(msg));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text("CHECK"),
                          ),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor)),
                        ))
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SecondPage.routeName,
                                arguments: nameController.text);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text("NEXT"),
                          ),
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor)),
                        ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
