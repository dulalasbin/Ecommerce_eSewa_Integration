import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shimmer/shimmer.dart';

import 'package:xennial/controllers/api_controler.dart';
import 'package:xennial/models/product_model.dart';
import 'package:xennial/views/components/product_detail.dart';
import 'package:xennial/views/utils/text_style.dart';

import 'utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Ionicons.grid_outline,
              color: black,
            ),
          ),
          title: ProductSearchBar(),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed('/cart');
              },
              icon: GetBuilder<ProductController>(builder: (contrller) {
                return Badge(
                  label: Text(contrller.cartProducts.length.toString()),
                  isLabelVisible: true,
                  child: const Icon(
                    Ionicons.cart_outline,
                    color: black,
                  ),
                );
              }),
            ),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find Your Style',
                style: headingBold,
              ),
              OutlinedButton(
                onPressed: () {},
                child: Text(
                  'All',
                  style: infoBold,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Flexible(
                child: AllAvailableProducts(),
              ),
            ],
          ),
        ));
  }
}

class AllAvailableProducts extends StatelessWidget {
  const AllAvailableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (controller) {
      int length = controller.products.length;
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Wrap(
              spacing: 0.5,
              runSpacing: 0.6,
              children: [
                for (int i = 0; i < length; i++) ...{
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        () => ProductDetailsPage(
                          product: controller.products[i],
                        ),
                      );
                    },
                    child: Container(
                      constraints:
                          BoxConstraints(maxHeight: 300, maxWidth: 180),
                      child: ProductCard(
                        product: controller.products[i],
                      ),
                    ),
                  ),
                }
              ],
            ),
          ),
        );
      }
    });
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: grey,
            spreadRadius: 0.3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    product.image.toString(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.title.toString().toUpperCase(),
                  style: infoBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: green,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(16)),
              ),
              child: Text(
                '\$${product.price}',
                style: infoBold,
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Icon(
              Ionicons.heart_outline,
              color: red,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductSearchBar extends StatelessWidget {
  const ProductSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: EdgeInsets.only(left: 24),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          width: 1,
          color: grey,
        ),
      ),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            cursorColor: black,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          )),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Ionicons.search_outline,
              color: black,
            ),
          ),
        ],
      ),
    );
  }
}
