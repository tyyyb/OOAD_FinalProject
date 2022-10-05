import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ooad_final_project_fall21/functions/Singleton/user.dart';
import 'package:ooad_final_project_fall21/net/firebase_services.dart';
import 'package:ooad_final_project_fall21/theme/colors.dart';
import 'package:ooad_final_project_fall21/widgets/sub_app_bar.dart';

class CartPage extends StatefulWidget {
  final Customer myCustomer;
  const CartPage({Key? key, required this.myCustomer}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
          child: SubAppBar(size: size, title: "Cart"),
          preferredSize: Size.fromHeight(80)),
      body: getBody(),
    );
  }

  Widget getBody() {
    FirebaseServices _firebaseServices = FirebaseServices();
    var size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(color: light),
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.usersRef
                .doc(widget.myCustomer.id)
                .collection("Cart")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view
                return ListView(
                  padding: const EdgeInsets.only(
                    top: 108.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data!.docs.map((document) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: textWhite,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: (size.width * 0.9),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Store: ${document['store']}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Product Name: ${document['name']}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Price: ${document['price'].toString()}",
                                            style: const TextStyle(
                                                color: textBlack, fontSize: 16),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete),
                                            onPressed: () {
                                              _firebaseServices.usersRef
                                                  .doc(widget.myCustomer.id)
                                                  .collection("Cart")
                                                  .doc(document.id)
                                                  .delete();
                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                            image:
                                                NetworkImage(document['image']),
                                            fit: BoxFit.cover)),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            // Container(
                            //   width: 80,
                            //   height: 80,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(12),
                            //       image: DecorationImage(
                            //           image: NetworkImage(document['image']),
                            //           fit: BoxFit.cover)),
                            // )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }

              // Loading State
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.info))],
      backgroundColor: primary,
    );
  }
}
