// package Decorator.vegetable;
//
import 'vegetable.dart';

class Broccoli extends Vegetable {
  Broccoli() : super() {
    name = "Broccoli";
    price = 5;
  }

  @override
  String getName() {
    return name;
  }

  @override
  double getPrice() {
    return price;
  }
}
