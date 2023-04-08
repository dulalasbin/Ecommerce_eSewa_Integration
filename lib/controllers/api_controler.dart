import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:xennial/models/checkout_model.dart';
import 'dart:convert';

import 'package:xennial/models/product_model.dart';

class ProductController extends GetxController {
  var products = <ProductModel>[].obs;
  var cartProducts = <ProductModel>[].obs;
  RxBool lableVisble = false.obs;
  var checkoutList = <CheckoutModel>[].obs;

  double totalPrice = 0.0;
  var isLoading = true.obs;

  @override
  void onReady() {
    fetchProducts();
    super.onReady();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var url = Uri.parse('https://fakestoreapi.com/products');
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var parsedJson = jsonDecode(response.body) as List<dynamic>;
        var apiData = parsedJson.map((e) => ProductModel.fromJson(e)).toList();
        products.value = apiData;
      }
    } finally {
      isLoading(false);
    }
  }

  labelFunction() {
    if (cartProducts.length > 0) {
      lableVisble.value = true;
    } else {
      lableVisble.value = false;
    }
  }

  addToCart(productId) {
    ProductModel result = products.firstWhere((map) => map.id == productId);

    if (cartProducts.contains(productId)) {
    } else {
      cartProducts.add(result);

      CheckoutModel checkM = CheckoutModel(
        id: productId,
        price: result.price,
        name: result.title,
        count: 1,
      );

      checkoutList.add(checkM);
    }
    getTotalPrice();
    labelFunction();
  }

  removeFromCart(productId) {
    ProductModel result = products.firstWhere((map) => map.id == productId);
    cartProducts.remove(result);

    CheckoutModel resultdata = checkoutList.firstWhere(
      (data) => data.id == productId,
    );

    checkoutList.remove(resultdata);
    getTotalPrice();
    labelFunction();
    update();
  }

  addToCheckout(productId, arg) {
    CheckoutModel resultdata = checkoutList.firstWhere(
        (data) => data.id == productId,
        orElse: () => CheckoutModel(id: productId, count: 1));

    if (arg) {
      resultdata.count = resultdata.count! + 1;
    } else {
      if (resultdata.count != 0) {
        resultdata.count = resultdata.count! - 1;
      }
    }
    getTotalPrice();
    update();
  }

  getTotalPrice() {
    double total = 0.0;
    for (int i = 0; i < checkoutList.length; i++) {
      total += checkoutList[i].count! * checkoutList[i].price!;
    }
    totalPrice = (total * 129);
  }
}
