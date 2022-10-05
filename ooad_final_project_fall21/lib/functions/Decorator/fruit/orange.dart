// package Decorator.fruit;
//
import 'fruit.dart';

class Orange extends Fruit {
  Orange() : super() {
    name = "Orange";
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
