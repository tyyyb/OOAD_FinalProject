// package Decorator.vegetable;
//
import 'vegetable.dart';

class Pepper extends Vegetable {
  Pepper() : super() {
    name = "Pepper";
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
