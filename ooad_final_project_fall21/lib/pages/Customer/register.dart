import 'package:flutter/material.dart';
import 'package:ooad_final_project_fall21/functions/Singleton/user.dart';
import 'package:ooad_final_project_fall21/net/firebase_services.dart';
import 'package:ooad_final_project_fall21/pages/Store/register_store.dart';
import 'package:ooad_final_project_fall21/pages/login.dart';
import 'package:ooad_final_project_fall21/pages/root_app.dart';
import 'package:ooad_final_project_fall21/theme/colors.dart';
import 'package:ooad_final_project_fall21/theme/padding.dart';

class RegisterPage extends StatefulWidget {
  final Customer myCustomer;
  const RegisterPage({Key? key, required this.myCustomer}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

enum SingingCharacter { lafayette, jefferson }

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameField = TextEditingController();
  final TextEditingController _phoneField = TextEditingController();

  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _pwdField = TextEditingController();
  final TextEditingController _pwdCrmField = TextEditingController();
  int _radioValue1 = -1;

  FirebaseServices _firebaseServices = FirebaseServices();

  bool _isHidden = true;
  bool _isHiddenCrm = true;

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Boulder FM",
                  style: TextStyle(
                      color: primary,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Your Local Farmer's Market",
                  style: TextStyle(
                      color: primary,
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 16,
                            color: grey,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FittedBox(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          // width: 1,
                          height: 45,
                          decoration: BoxDecoration(
                              color: textFieldBg,
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: TextField(
                              cursorColor: textBlack,
                              controller: _nameField,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Preferred Name"),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Role",
                        style: TextStyle(
                            fontSize: 16,
                            color: grey,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio(
                            value: 0,
                            groupValue: _radioValue1,
                            onChanged: (value) {
                              setState(() {
                                _radioValue1 = 0;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          Text(
                            'Customer',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                          new Radio(
                            value: 1,
                            groupValue: _radioValue1,
                            onChanged: (value) {
                              setState(() {
                                _radioValue1 = 1;
                              });
                            },
                          ),
                          new Text(
                            'Store',
                            style: new TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ]),
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Phone Number",
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
                            controller: _phoneField,
                            cursorColor: textBlack,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "(012) 345-6789"),
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
                const Text(
                  "Email Address",
                  style: TextStyle(
                      fontSize: 16, color: grey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
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
                    child: TextField(
                      cursorColor: textBlack,
                      controller: _emailField,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "boulderfm@something.com"),
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
                  "Password",
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
                              controller: _pwdField,
                              obscureText: _isHidden,
                              cursorColor: textBlack,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Password",
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isHidden = !_isHidden;
                                    });
                                  },
                                  child: Icon(
                                      _isHidden
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 18),
                                ),
                              )),
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
                  "Comfirm Password",
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
                              controller: _pwdCrmField,
                              obscureText: _isHiddenCrm,
                              cursorColor: textBlack,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter Password",
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isHiddenCrm = !_isHiddenCrm;
                                    });
                                  },
                                  child: Icon(
                                      _isHiddenCrm
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 18),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("/root_app", (route) => false);
              },
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
                          bool shouldNavigate = await _firebaseServices
                              .register(_emailField.text, _pwdField.text);

                          if (shouldNavigate) {
                            Map<String, dynamic>? userMap =
                                await _firebaseServices.addUser(
                                    _emailField.text,
                                    _nameField.text,
                                    _phoneField.text,
                                    _radioValue1);
                            widget.myCustomer.setId = userMap!['uid'];
                            widget.myCustomer.setName = _nameField.text;
                            widget.myCustomer.setPhoneNumber = _phoneField.text;
                            widget.myCustomer.setEmail = _emailField.text;
                            if (_radioValue1 == 0) {
                              widget.myCustomer.setRole = "Customer";
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RootApp(
                                          myCustomer: widget.myCustomer)));
                            } else if (_radioValue1 == 1) {
                              widget.myCustomer.setRole = "Store";

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterStorePage(
                                          myCustomer: widget.myCustomer)));
                            }
                          }
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 16,
                              color: textWhite,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account yet?",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(myCustomer: widget.myCustomer)));
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
