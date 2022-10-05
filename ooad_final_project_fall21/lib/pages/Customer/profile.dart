import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ooad_final_project_fall21/functions/Singleton/user.dart';
import 'package:ooad_final_project_fall21/net/firebase_services.dart';
import 'package:ooad_final_project_fall21/pages/login.dart';
import 'package:ooad_final_project_fall21/theme/colors.dart';

class ProfilePage extends StatefulWidget {
  final Customer myCustomer;
  const ProfilePage({Key? key, required this.myCustomer}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    widget.myCustomer.reset();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(myCustomer: widget.myCustomer)));
  }

  String _updateUser(Map<String, String> userInfo) {
    widget.myCustomer.setName = userInfo['userName']!;
    widget.myCustomer.setEmail = userInfo['userEmail']!;
    widget.myCustomer.setPhoneNumber = userInfo['userPhone']!;

    try {
      _firebaseServices.usersRef.doc(widget.myCustomer.id).update(userInfo);
      setState(() {});

      return "Success";
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
    final TextEditingController _nameField =
        TextEditingController(text: widget.myCustomer.name);
    final TextEditingController _phoneField =
        TextEditingController(text: widget.myCustomer.phoneNumber);
    final TextEditingController _emailField =
        TextEditingController(text: widget.myCustomer.email);

    return Padding(
      padding: const EdgeInsets.only(left: 50, top: 50, right: 50, bottom: 100),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "User Profile",
                style: TextStyle(
                    color: primary, fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                "User Information",
                style: TextStyle(
                    color: primary,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "User Name:",
                      style: TextStyle(
                          fontSize: 16,
                          color: grey,
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      controller: _nameField,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "User Email:",
                      style: TextStyle(
                          fontSize: 16,
                          color: grey,
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      controller: _emailField,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Phone number:",
                      style: TextStyle(
                          fontSize: 16,
                          color: grey,
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      controller: _phoneField,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Role:",
                      style: TextStyle(
                          fontSize: 16,
                          color: grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: Text(widget.myCustomer.role),
                    ),
                  ],
                ),
              ],
            ),
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
                        String message = _updateUser({
                          'userEmail': _emailField.text,
                          'userName': _nameField.text,
                          'userPhone': _phoneField.text,
                        });

                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                scrollable: true,
                                title: Text("Message"),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    child: Text(message),
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                      child: const Text("Close"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.red),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })
                                ],
                              );
                              setState(() {});
                            });
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(
                            fontSize: 16,
                            color: textWhite,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
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
                        _signOut();
                      },
                      child: const Text(
                        "Log out",
                        style: TextStyle(
                            fontSize: 16,
                            color: textWhite,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
