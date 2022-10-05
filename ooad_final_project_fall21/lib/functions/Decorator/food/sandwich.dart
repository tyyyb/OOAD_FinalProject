// package Decorator.food;
//
import 'food.dart';

class Sandwich extends Food {
  Sandwich() : super() {
    name = "Sanwitch";
    price = 3;
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
