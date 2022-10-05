import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ooad_final_project_fall21/functions/Observers/store.dart';
import 'package:ooad_final_project_fall21/functions/Singleton/user.dart';
import 'package:ooad_final_project_fall21/net/firebase_services.dart';
import 'package:ooad_final_project_fall21/pages/Customer/register.dart';
import 'package:ooad_final_project_fall21/pages/root_app.dart';
import 'package:ooad_final_project_fall21/theme/colors.dart';
import 'package:ooad_final_project_fall21/theme/padding.dart';

import 'Store/store_home.dart';

class LoginPage extends StatefulWidget {
  final Customer myCustomer;
  const LoginPage({Key? key, required this.myCustomer}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _pwdField = TextEditingController();
  bool _isHidden = true;
  FirebaseServices _firebaseServices = FirebaseServices();

  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Container(
              child: Text(error),
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

  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailField.text, password: _pwdField.text);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(mainPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Boulder FM",
                style: TextStyle(
                    color: primary, fontSize: 40, fontWeight: FontWeight.bold),
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
                    color: textFieldBg, borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    cursorColor: textBlack,
                    controller: _emailField,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Email Address"),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
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
                    color: textFieldBg, borderRadius: BorderRadius.circular(5)),
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
            height: 10,
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
                        String? _loginFeedback = await _loginAccount();
                        if (_loginFeedback == null) {
                          User? user = FirebaseAuth.instance.currentUser;
                          var userMap = await _firebaseServices.getCurrUser();
                          widget.myCustomer.setId = user.uid;
                          widget.myCustomer.setName = userMap!['userName'];
                          widget.myCustomer.setPhoneNumber =
                              userMap['userPhone'];
                          widget.myCustomer.setEmail = userMap['userEmail'];
                          widget.myCustomer.setRole = userMap['userRole'];

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RootApp(myCustomer: widget.myCustomer)));
                        } else {
                          _alertDialogBuilder(_loginFeedback);
                        }
                      },
                      child: const Text(
                        "Login",
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
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/root_app", (route) => false);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 45,
              decoration: BoxDecoration(
                  color: primary, borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      onPressed: () async {
                        String? _loginFeedback = await _loginAccount();
                        if (_loginFeedback == null) {
                          User? user = FirebaseAuth.instance.currentUser;
                          Store? myStore =
                              await _firebaseServices.getStore(user.uid);
                          if (myStore != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoreHomePage(
                                        store: myStore,
                                        myCustomer: widget.myCustomer)));
                          } else {
                            _alertDialogBuilder(_loginFeedback!);
                          }
                        } else {
                          _alertDialogBuilder(_loginFeedback);
                        }
                      },
                      child: const Text(
                        "Login As Store",
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
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/root_app", (route) => false);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 45,
              decoration: BoxDecoration(
                  color: primary, borderRadius: BorderRadius.circular(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RootApp(myCustomer: widget.myCustomer)));
                      },
                      child: const Text(
                        "Login as Guest",
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
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Does not have an account yet?",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegisterPage(myCustomer: widget.myCustomer)));
                  },
                  child: Text(
                    " Create One",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
