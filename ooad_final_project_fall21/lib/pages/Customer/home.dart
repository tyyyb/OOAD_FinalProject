import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ooad_final_project_fall21/functions/Observers/store.dart';
import 'package:ooad_final_project_fall21/functions/Singleton/user.dart';
import 'package:ooad_final_project_fall21/net/firebase_services.dart';
import 'package:ooad_final_project_fall21/theme/colors.dart';
import 'package:ooad_final_project_fall21/theme/padding.dart';
import 'package:ooad_final_project_fall21/widgets/main_app_bar.dart';
import 'package:ooad_final_project_fall21/widgets/store_card.dart';

import 'store_detail.dart';

class HomePage extends StatefulWidget {
  final Customer myCustomer;
  const HomePage({
    Key? key,
    required this.myCustomer,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: textWhite,
      appBar: PreferredSize(
          child: MainAppBar(size: size), preferredSize: Size.fromHeight(80)),
      body: getBody(),
    );
  }

  Widget getBody() {
    final CollectionReference _productsRef =
        FirebaseFirestore.instance.collection("stores");
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: light),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view
                return ListView(
                  padding: EdgeInsets.only(
                    top: 10.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data!.docs.map((document) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: bottomMainPadding),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StoreDetailPage(
                                        image: document.data()['image'],
                                        name: document.data()['name'],
                                        user: widget.myCustomer,
                                        store: Store(document.data()['name'],
                                            document.id),
                                      )));
                        },
                        child: StoreCard(
                            width: size.width - (mainPadding * 2),
                            store: document.data()),
                      ),
                    );
                  }).toList(),
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
      ),
    );
  }
}
