import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ooad_final_project_fall21/pages/landing_page.dart';

import 'functions/Singleton/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Customer myCustomer = Customer.getCustomer();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: router.generateRoute,
      // home: LoginPage(),
      home: LandingPage(myCustomer),
    );
  }
}
