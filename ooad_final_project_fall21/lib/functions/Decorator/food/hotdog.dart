// package Decorator.food;
//
import 'food.dart';

class HotDog extends Food {
  HotDog() : super() {
    name = "HotDog";
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
