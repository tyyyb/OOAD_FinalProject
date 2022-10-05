import 'package:flutter/material.dart';
import 'package:ooad_final_project_fall21/functions/Observers/store.dart';
import 'package:ooad_final_project_fall21/functions/Singleton/user.dart';
import 'package:ooad_final_project_fall21/net/firebase_services.dart';
import 'package:ooad_final_project_fall21/theme/colors.dart';
import 'package:ooad_final_project_fall21/theme/padding.dart';

import 'store_home.dart';

class RegisterStorePage extends StatefulWidget {
  final Customer myCustomer;
  const RegisterStorePage({required this.myCustomer, Key? key})
      : super(key: key);

  @override
  _RegisterStorePageState createState() => _RegisterStorePageState();
}

enum SingingCharacter { lafayette, jefferson }

class _RegisterStorePageState extends State<RegisterStorePage> {
  final TextEditingController _nameField = TextEditingController();
  final TextEditingController _hrField = TextEditingController();
  FirebaseServices _firebaseServices = FirebaseServices();

  String dropdownvalue = 'Fruit';
  var items = ['Fruit', 'Vegetable', 'Food', 'Meat'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: getBody(),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(mainPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Register Your Store",
                  style: TextStyle(
                      color: primary,
                      fontSize: 30,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Store Name",
                  style: TextStyle(
                      fontSize: 16, color: grey, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: textFieldBg,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: _nameField,
                            cursorColor: textBlack,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Your Store's Name"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Store Type",
                  style: TextStyle(
                      fontSize: 16, color: grey, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: DropdownButton(
                    value: dropdownvalue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(value: items, child: Text(items));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownvalue = newValue.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Store Hours",
                  style: TextStyle(
                      fontSize: 16, color: grey, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: textFieldBg,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            controller: _hrField,
                            cursorColor: textBlack,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Hours"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {},
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: 45,
                decoration: BoxDecoration(
                    color: primary, borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                        onPressed: () async {
                          Store newStore =
                              Store.initial(_nameField.text, dropdownvalue);
                          String? shouldNavigate =
                              await _firebaseServices.addStore(newStore);
                          print(shouldNavigate);
                          if (shouldNavigate != null) {
                            newStore.id = shouldNavigate;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoreHomePage(
                                        store: newStore,
                                        myCustomer: widget.myCustomer)));
                          } else {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Error"),
                                    content: Container(
                                      child: Text("Error"),
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text("Close"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 16,
                              color: textWhite,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
