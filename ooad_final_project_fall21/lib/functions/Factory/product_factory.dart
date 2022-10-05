import 'package:ooad_final_project_fall21/functions/Observers/store.dart';
import 'package:ooad_final_project_fall21/net/firebase_services.dart';

class ProductFactory {
  ProductFactory();

  void addProducts(Map<String, dynamic> product, Store store) {
    // widget.store.notifyObservers(news);
    FirebaseServices _firebaseServices = FirebaseServices();
    _firebaseServices.storeRef
        .doc(store.id)
        .collection("products")
        .add(product);
  }
}
