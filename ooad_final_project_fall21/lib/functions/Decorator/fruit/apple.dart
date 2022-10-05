// package Decorator.fruit;
//
import 'fruit.dart';

class Apple extends Fruit {
  Apple() : super() {
    name = "Apple";
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
