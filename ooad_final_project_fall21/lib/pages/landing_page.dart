import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ooad_final_project_fall21/functions/Singleton/user.dart';
import 'package:ooad_final_project_fall21/pages/root_app.dart';

import 'login.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  Customer myCustomer;

  LandingPage(this.myCustomer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
              body: Center(
            child: Text("Error:${snapshot.error}"),
          ));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${streamSnapshot.error}"),
                    ),
                  );
                }
                if (streamSnapshot.connectionState == ConnectionState.active) {
                  // Get the user
                  User? _user = streamSnapshot.data as User?;
                  // If the user is null, we're not logged in
                  if (_user == null) {
                    // user not logged in, head to login
                    return LoginPage(myCustomer: myCustomer);
                  } else {
                    // The user is logged in, head to homepage
                    return RootApp(myCustomer: myCustomer);
                  }
                }

                return const Scaffold(
                  body: Center(
                    child: Text(
                      "Checking Authentication...",
                    ),
                  ),
                );
              });
        }

        return Scaffold(
          body: Center(
            child: Text(
              "Initialization App...",
            ),
          ),
        );
      },
    );
  }
}
