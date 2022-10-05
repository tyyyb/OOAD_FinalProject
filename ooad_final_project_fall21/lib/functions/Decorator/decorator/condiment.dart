import 'package:ooad_final_project_fall21/functions/Decorator/decorator/decorator.dart';
import 'package:ooad_final_project_fall21/functions/Decorator/item.dart';

class Condiment extends Decorator {
  Condiment(Item item) : super(item) {
    name = "Condiment";
  }

  @override
  String getName() {
    // TODO: implement getName
    return item.getName() + " with Condiment";
  }

  @override
  double getPrice() {
    // TODO: implement getPrice
    return item.getPrice() + 1;
  }
}
