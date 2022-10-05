import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ooad_final_project_fall21/functions/Decorator/decorator/bag.dart';
import 'package:ooad_final_project_fall21/functions/Decorator/item.dart';
import 'package:ooad_final_project_fall21/functions/Observers/store.dart';
import 'package:ooad_final_project_fall21/functions/Singleton/user.dart';
import 'package:ooad_final_project_fall21/net/firebase_services.dart';
import 'package:ooad_final_project_fall21/theme/colors.dart';

class StoreDetailPage extends StatefulWidget {
  final String image;
  final String name;
  final Customer user;
  final Store store;
  const StoreDetailPage({
    Key? key,
    required this.image,
    required this.name,
    required this.user,
    required this.store,
  }) : super(key: key);

  @override
  _StoreDetailPageState createState() => _StoreDetailPageState();
}

class _StoreDetailPageState extends State<StoreDetailPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  Future _addToCart(Item product) {
    return _firebaseServices.usersRef
        .doc(widget.user.id)
        .collection("Cart")
        .doc(product.id)
        .set({
      'name': product.getName(),
      "price": product.getPrice(),
      "quantity": 1,
      "store": widget.store.storeName,
      "image": product.image,
    });
  }

  Future _addToSavedStore(Store store) {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("SavedStore")
        .doc(store.id)
        .set({'name': store.storeName});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: getAppBar(), preferredSize: Size.fromHeight(200)),
      body: getBody(),
      // bottomNavigationBar: getFooter(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back, color: Colors.white),
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.info))],
      backgroundColor: primary,
      flexibleSpace: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.image), fit: BoxFit.cover)),
          ),
          Container(
            decoration: BoxDecoration(color: textBlack.withOpacity(0.5)),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          color: textWhite,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 2, color: textWhite)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 8, top: 8),
                      child: TextButton(
                        onPressed: () {
                          _addToSavedStore(widget.store);
                        },
                        child: const Text(
                          "Subscribe",
                          style: TextStyle(
                              fontSize: 16,
                              color: textWhite,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getBody() {
    final CollectionReference _productsRef = FirebaseFirestore.instance
        .collection("stores")
        .doc(widget.store.id)
        .collection("products");
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Products for today",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
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
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      children: snapshot.data!.docs.map((document) {
                        Item myProduct = Item.init(
                            document.id,
                            document['name'],
                            document['price'].toDouble(),
                            document['image']);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: (size.width * 0.75) - 40,
                                height: 80,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      document['name'],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\$${document['price']} /${document['unit'] ?? "unit"}",
                                          style: const TextStyle(
                                              color: textBlack, fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                              Icons.add_circle_outline_rounded),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return _openPopup(
                                                      context, myProduct);
                                                });
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                        image: NetworkImage(document['image']),
                                        fit: BoxFit.cover)),
                              )
                            ],
                          ),
                        );
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

  _openPopup(context, myProduct) {
    return AlertDialog(
      scrollable: true,
      title: Text("Add Bag"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              Text("Would you like to add a bag?"),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
            child: const Text("Yes"),
            onPressed: () {
              _addToCart(Bag(myProduct));
              Navigator.pop(context);
            }),
        ElevatedButton(
            child: const Text("No, Thank you"),
            onPressed: () {
              _addToCart(myProduct);
              Navigator.pop(context);
            }),
        ElevatedButton(
            child: const Text("Close"),
            style: ElevatedButton.styleFrom(primary: Colors.red),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}
