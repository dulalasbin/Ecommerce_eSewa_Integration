class CheckoutModel {
  int? id;
  String? name;
  double? price;
  int? count;

  CheckoutModel({
    this.id,
    this.price,
    this.name,
    this.count = 1,
  });

  CheckoutModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toDouble();
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['count'] = count;
    data['name'] = name;
    return data;
  }
}
