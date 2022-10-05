import 'package:ooad_final_project_fall21/functions/Decorator/decorator/decorator.dart';
import 'package:ooad_final_project_fall21/functions/Decorator/item.dart';

class Cream extends Decorator {
  Cream(Item item) : super(item) {
    name = "Cream";
  }

  @override
  String getName() {
    // TODO: implement getName
    return item.getName() + " with Cream";
  }

  @override
  double getPrice() {
    // TODO: implement getPrice
    return item.getPrice() + 1;
  }
}
