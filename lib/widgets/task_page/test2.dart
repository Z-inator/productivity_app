class DueTask {
  bool isExpanded;
  String header;
  BodyModel bodyModel;

  DueTask({this.isExpanded, this.header, this.bodyModel});
}

class BodyModel {
  int price;
  int quantity;

  BodyModel({this.price, this.quantity});
}