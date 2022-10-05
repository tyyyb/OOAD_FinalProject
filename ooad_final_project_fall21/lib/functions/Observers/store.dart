import 'package:ooad_final_project_fall21/functions/Observers/observer.dart';
import 'package:ooad_final_project_fall21/functions/Observers/subject.dart';
import 'package:ooad_final_project_fall21/net/firebase_services.dart';

class Store implements Subject {
  List<Observer> observerList = [];
  late String storeName;
  late String id;
  late String store_type;
  late String image =
      "https://firebasestorage.googleapis.com/v0/b/boulder-fm.appspot.com/o/store.jpg?alt=media&token=0c43d6f3-2e35-4bbb-98e1-d1af40b2e086";
  bool isOpen = true;
  // Store();
  Store(this.storeName, this.id);
  Store.initial(this.storeName, this.store_type);
  Store.convert(this.id, Map<String, dynamic> map) {
    storeName = map['name'];
    isOpen = map['is_open'];
    store_type = map['store_type'];
    image = map['image'];
  }

  @override
  void notifyObservers(Map<String, String> news) {
    // TODO: implement notifyObservers

    // widget.store.notifyObservers(news);
    FirebaseServices _firebaseServices = FirebaseServices();
    _firebaseServices.storeRef.doc(id).collection("news").add(news);
  }

  @override
  void registerObserver(Observer observer) {
    // TODO: implement registerObserver
    observerList.add(observer);
  }

  @override
  void removeObserver(Observer observer) {
    // TODO: implement removeObserver
    observerList.remove(observer);
  }
}
