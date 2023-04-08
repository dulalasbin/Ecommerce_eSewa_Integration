import 'package:get/get.dart';

import '../components/cart.dart';
import '../home_page.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: '/homepage',
    page: () => HomePage(),
    transition: Transition.cupertino,
    transitionDuration: Duration(
      milliseconds: 600,
    ),
  ),
  GetPage(
    name: '/cart',
    page: () => CartPage(),
    transition: Transition.cupertino,
    transitionDuration: Duration(
      milliseconds: 600,
    ),
  ),
];
