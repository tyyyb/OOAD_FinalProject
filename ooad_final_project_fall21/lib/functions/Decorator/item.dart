// import java.util.Random;
//
class Item {
  late String id;
  late String name;
  late double price;
  late String itemType;
  late String image;

  Item();
  Item.init(this.id, this.name, this.price, this.image);
  Item.copy(Item item2) {
    id = item2.id;
    name = item2.name;
    price = item2.price;
    itemType = "Decorator";
    image = item2.image;
  }

  String getName() {
    return name;
  }

  double getPrice() {
    return price;
  }
}
