// package Decorator.meat;
//
import 'meat.dart';

class Beef extends Meat {
  Beef() : super() {
    name = "Beef";
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
