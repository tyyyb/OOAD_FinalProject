// package Decorator.vegetable;
//
import 'vegetable.dart';

class Corn extends Vegetable {
  Corn() : super() {
    name = "Corn";
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
