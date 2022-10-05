// package Decorator.meat;
//
import 'meat.dart';

class Lamb extends Meat {
  Lamb() : super() {
    name = "Lamb";
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
