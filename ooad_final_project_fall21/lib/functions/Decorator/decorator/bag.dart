import 'package:ooad_final_project_fall21/functions/Decorator/decorator/decorator.dart';
import 'package:ooad_final_project_fall21/functions/Decorator/item.dart';

class Bag extends Decorator {
  Bag(Item item) : super(item) {
    name = "Bag";
  }

  @override
  String getName() {
    return item.getName() + " with Bag";
  }

  @override
  double getPrice() {
    // TODO: implement getPrice
    return item.getPrice() + 1;
  }
}
