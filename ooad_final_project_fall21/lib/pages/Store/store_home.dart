import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ooad_final_project_fall21/functions/Decorator/item.dart';
import 'package:ooad_final_project_fall21/functions/Factory/product_factory.dart';
import 'package:ooad_final_project_fall21/functions/Observers/store.dart';
import 'package:ooad_final_project_fall21/functions/Singleton/user.dart';
import 'package:ooad_final_project_fall21/net/firebase_services.dart';
import 'package:ooad_final_project_fall21/theme/colors.dart';

import '../login.dart';

class StoreHomePage extends StatefulWidget {
  final Store store;
  final Customer myCustomer;
  const StoreHomePage({
    required this.store,
    required this.myCustomer,
    Key? key,
  }) : super(key: key);

  @override
  _StoreHomePageState createState() => _StoreHomePageState();
}

class _StoreHomePageState extends State<StoreHomePage> {
  String image =
      "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";
  // Store mystore = new Store();
  ProductFactory myFactory = ProductFactory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: getAppBar(), preferredSize: Size.fromHeight(200)),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.info))],
      backgroundColor: primary,
      flexibleSpace: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.store.image),
                    fit: BoxFit.cover)),
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
                      widget.store.storeName,
                      style: TextStyle(
                          color: textWhite,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 2, color: textWhite),
                          ),
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _addProductPopup(
                                        context, "Add Product", addProducts);
                                  });
                            },
                            child: const Text(
                              "Add Product",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: textWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 2, color: textWhite)),
                          child: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _openPopup(
                                        context, "Post News", postNews);
                                  });
                            },
                            child: const Text(
                              "Post News",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: textBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 2, color: textWhite)),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage(
                                          myCustomer: widget.myCustomer)));
                            },
                            child: const Text(
                              "Close Store",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: textWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                                          "\$${document['price']} /${document['unit']}",
                                          style: const TextStyle(
                                              color: textBlack, fontSize: 16),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            _productsRef
                                                .doc(document.id)
                                                .delete();
                                            setState(() {});
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

  _openPopup(context, title, function) {
    final TextEditingController _txtController = TextEditingController();

    return AlertDialog(
      scrollable: true,
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _txtController,
                decoration: const InputDecoration(
                  labelText: 'Put something here....',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
            child: const Text("Submit"),
            onPressed: () {
              function(_txtController.text);
            })
      ],
    );
  }

  void postNews(String info) {
    Map<String, String> news = {
      "store_name": widget.store.storeName,
      "news": info,
      "created_at": DateTime.now().toString(),
    };
    widget.store.notifyObservers(news);
    Navigator.pop(context);
    setState(() {});
  }

  // One Example of use of Factory Pattern
  void addProducts(Map<String, dynamic> product) {
    myFactory.addProducts(product, widget.store);
    Navigator.pop(context);
    setState(() {});
  }

  void deleteProducts(Map<String, dynamic> product) {
    FirebaseServices _firebaseServices = FirebaseServices();
    _firebaseServices.storeRef
        .doc(widget.store.id)
        .collection("products")
        .add(product);
    Navigator.pop(context);
    setState(() {});
  }

  _addProductPopup(context, title, function) {
    TextEditingController _productNameController = TextEditingController();
    TextEditingController _productPriceController = TextEditingController();
    String dropdownvalue = 'lb';
    var items = ['lb', 'each'];
    return AlertDialog(
      scrollable: true,
      title: Text(title),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text("Name:"),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _productNameController,
                      decoration: const InputDecoration(
                        labelText: 'Product Name....',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Price:"),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: _productPriceController,
                      decoration: const InputDecoration(
                        labelText: 'Product Price....',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Unit:"),
                  SizedBox(width: 8),
                  StatefulBuilder(builder:
                      (BuildContext context, StateSetter dropDownState) {
                    return DropdownButton<String>(
                      value: dropdownvalue,
                      underline: Container(),
                      items: items.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(
                            value,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        dropDownState(() {
                          dropdownvalue = value!;
                        });
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
            child: const Text("Submit"),
            onPressed: () {
              Map<String, dynamic> product = {
                "price": int.parse(_productPriceController.text),
                "name": _productNameController.text,
                "unit": dropdownvalue,
                "image":
                    "https://firebasestorage.googleapis.com/v0/b/boulder-fm.appspot.com/o/Item.png?alt=media&token=41047d7a-8247-4298-adcd-0f6c9981caee"
              };
              function(product);
            })
      ],
    );
  }
}
