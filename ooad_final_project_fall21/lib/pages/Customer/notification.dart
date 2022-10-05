import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ooad_final_project_fall21/functions/Singleton/user.dart';
import 'package:ooad_final_project_fall21/net/firebase_services.dart';
import 'package:ooad_final_project_fall21/theme/colors.dart';
import 'package:ooad_final_project_fall21/theme/padding.dart';
import 'package:ooad_final_project_fall21/widgets/sub_app_bar.dart';

class NotificationPage extends StatefulWidget {
  final Customer myCustomer;
  const NotificationPage({Key? key, required this.myCustomer})
      : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: textWhite,
      appBar: PreferredSize(
          child: SubAppBar(size: size, title: "Notification"),
          preferredSize: Size.fromHeight(80)),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(mainPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Trending Now",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Updates from the Market",
                style:
                    TextStyle(fontSize: 15, color: textBlack.withOpacity(0.8)),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.usersRef
                    .doc(_firebaseServices.getUserId())
                    .collection("SavedStore")
                    .get(),
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
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      children: snapshot.data!.docs.map((document) {
                        return FutureBuilder<QuerySnapshot>(
                            future: _firebaseServices.storeRef
                                .doc(document.id)
                                .collection("news")
                                .get(),
                            builder: (context, newsSnap) {
                              if (newsSnap.hasError) {
                                return Container(
                                  child: Center(
                                    child: Text("${newsSnap.error}"),
                                  ),
                                );
                              }

                              if (newsSnap.connectionState ==
                                  ConnectionState.done) {
                                // Map<String, dynamic> data = newsSnap.data!.data() as Map<String, dynamic>;

                                return ListView(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(
                                      top: 10.0,
                                    ),
                                    children:
                                        newsSnap.data!.docs.map((document) {
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${document['store_name']} -- ",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                document['news'],
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${document['created_at']}",
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 30),
                                        ],
                                      );
                                    }).toList());
                              }

                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            });
                      }).toList(),
                    );
                  }

                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
