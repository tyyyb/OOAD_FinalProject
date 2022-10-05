// package Decorator.fruit;
//
import 'fruit.dart';

class Peach extends Fruit {
  Peach() : super() {
    name = "Peach";
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
