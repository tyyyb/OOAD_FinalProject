import 'package:ooad_final_project_fall21/functions/Decorator/item.dart';

abstract class Decorator extends Item {
  final Item item;
  Decorator(this.item) : super.copy(item) {}

  @override
  String getName() {
    return item.getName();
  }

  @override
  double getPrice() {
    return item.getPrice();
  }
}
