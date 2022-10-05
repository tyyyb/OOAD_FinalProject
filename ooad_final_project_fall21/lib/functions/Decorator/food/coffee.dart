// package Decorator.food;
//
import 'food.dart';

class Coffee extends Food {
  Coffee(double price) : super() {
    name = "Coffee";
    this.price = price;
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
