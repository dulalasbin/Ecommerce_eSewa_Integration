import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:xennial/controllers/api_controler.dart';

import 'package:xennial/views/utils/colors.dart';
import 'package:xennial/views/utils/text_style.dart';

import '../../controllers/esewa_controller.dart';
import '../../models/checkout_model.dart';
import '../../models/product_model.dart';
import '../widgets/basic_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(EsewaController());
    return BasicPageWidget(
      title: 'My Cart',
      child: GetBuilder<ProductController>(builder: (controller) {
        List<ProductModel> products = controller.cartProducts;
        return Center(
          child: Container(
            child: controller.cartProducts.isEmpty
                ? Text('Cart is Empty! ')
                : Column(
                    children: [
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              final product = products[index];

                              CheckoutModel checkoutData = controller
                                  .checkoutList
                                  .firstWhere((data) => data.id == product.id);

                              return Container(
                                margin: EdgeInsets.fromLTRB(12, 0, 12, 12),
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: grey,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      margin:
                                          EdgeInsets.only(left: 6, right: 16),
                                      padding: EdgeInsets.all(8),
                                      child: Image.network(product.image!),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              180,
                                          child: Text(
                                            '${product.title}',
                                            maxLines: 5,
                                            style: bodyText,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          '\$${product.price!.toStringAsFixed(2)}',
                                          style: subTitleBold,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Icon(
                                                      Ionicons.remove,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    controller.addToCheckout(
                                                        product.id, false);
                                                  },
                                                  padding: EdgeInsets.all(0),
                                                  constraints: BoxConstraints(),
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                        color: black,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  checkoutData.count.toString(),
                                                  style: subTitleBold,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                IconButton(
                                                  icon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Icon(
                                                      Ionicons.add,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    controller.addToCheckout(
                                                        product.id, true);
                                                  },
                                                  padding: EdgeInsets.all(0),
                                                  constraints: BoxConstraints(),
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                        color: black,
                                                        width: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            IconButton(
                                              icon: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Icon(
                                                  Ionicons.close,
                                                ),
                                              ),
                                              onPressed: () {
                                                controller
                                                    .removeFromCart(product.id);
                                              },
                                              padding: EdgeInsets.all(0),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                          child: Column(
                        children: [
                          Text(
                            'Rs. ${controller.totalPrice.toStringAsFixed(2)}',
                            style: subTitleBold,
                          ),
                          Container(
                            margin: EdgeInsets.all(12),
                            child:
                                GetBuilder<EsewaController>(builder: (context) {
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
                                  context.esewaPay(
                                      controller.totalPrice.toStringAsFixed(2));
                                },
                                child: Container(
                                  decoration: BoxDecoration(),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 30,
                                  ),
                                  child: Text(
                                    'Checkout',
                                    style: buttonBold,
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      )),
                    ],
                  ),
          ),
        );
      }),
    );
  }
}
