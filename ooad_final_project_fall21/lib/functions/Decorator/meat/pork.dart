// package Decorator.meat;
//
import 'meat.dart';

class Pork extends Meat {
  Pork() : super() {
    name = "Pork";
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
