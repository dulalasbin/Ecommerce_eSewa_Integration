import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:xennial/controllers/api_controler.dart';
import 'package:xennial/views/utils/text_style.dart';
import 'package:xennial/views/widgets/basic_page.dart';

import '../../models/product_model.dart';
import '../utils/colors.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasicPageWidget(
      title: '',
      actions: [
        SizedBox(
          width: 20,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Ionicons.heart_outline,
            color: red,
          ),
        ),
      ],
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  product.title!,
                  textAlign: TextAlign.center,
                  style: titleBold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '\$${product.price!.toStringAsFixed(2)}',
                style: subTitleBold,
              ),
              SizedBox(height: 8.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(product.image!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'In Stock',
                        style: infoBold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      product.description!,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: GetBuilder<ProductController>(builder: (context) {
              return MaterialButton(
                color: black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: BorderSide(
                      color: black,
                      width: 1,
                    )),
                splashColor: grey,
                onPressed: () {
                  context.addToCart(product.id);
                },
                child: Container(
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 30,
                  ),
                  child: Text(
                    'Add To Cart',
                    style: buttonBold,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
