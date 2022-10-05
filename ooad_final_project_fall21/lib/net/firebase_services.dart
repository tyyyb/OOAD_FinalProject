import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ooad_final_project_fall21/functions/Observers/store.dart';
import 'package:ooad_final_project_fall21/functions/Singleton/user.dart';

class FirebaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final CollectionReference storeRef =
      FirebaseFirestore.instance.collection("stores");

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection("users");

  late Customer currCustomer;
  String getUserId() {
    if (_firebaseAuth.currentUser == null) {
      return "guest";
    } else {
      return _firebaseAuth.currentUser.uid;
    }
  }

  Future<Map<String, dynamic>?>? getCurrUser() async {
    if (_firebaseAuth.currentUser == null) {
      return null;
    } else {
      String uid = _firebaseAuth.currentUser.uid;
      var user = await usersRef.doc(uid).get();
      Map<String, dynamic> userMap = user.data();
      return userMap;
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('This password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>?> addUser(
      String email, String name, String phone, int role_num) async {
    try {
      String uid = getUserId();
      String role = "";
      switch (role_num) {
        case 0:
          role = "Customer";
          break;
        case 1:
          role = "Store";
          break;
      }
      Map<String, dynamic> userMap = {
        'uid': uid,
        'userEmail': email,
        'userName': name,
        'userPhone': phone,
        "userRole": role
      };
      await usersRef.doc(uid).set(userMap);
      return userMap;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<String?> addStore(Store store) async {
    try {
      var stores = storeRef.doc();
      await stores.set({
        "name": store.storeName,
        'store_type': store.store_type,
        "is_open": store.isOpen,
        "image": store.image
      });

      await usersRef.doc(FirebaseAuth.instance.currentUser.uid).update({
        'storeId': stores.id,
      });
      return stores.id;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Store?> getStore(String userId) async {
    Map<String, dynamic> value = {};
    try {
      var user = await usersRef.doc(userId).get();
      Map<String, dynamic> value2 = user.data();
      String? storeId = value2['storeId'];
      var store = await storeRef.doc(storeId).get();
      value = store.data();
      Store myStore = Store.convert(storeId!, value);
      return myStore;
    } catch (e) {
      print(e.toString());
    }
  }
}
