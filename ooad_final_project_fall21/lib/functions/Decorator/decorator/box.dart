import 'package:ooad_final_project_fall21/functions/Decorator/decorator/decorator.dart';
import 'package:ooad_final_project_fall21/functions/Decorator/item.dart';

class Box extends Decorator {
  Box(Item item) : super(item) {
    name = "Box";
  }

  @override
  String getName() {
    return item.getName() + " with Box";
  }

  @override
  double getPrice() {
    // TODO: implement getPrice
    return item.getPrice() + 1;
  }
}
