import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controllers/api_controler.dart';
import 'views/error_page.dart';
import 'views/utils/routes.dart';

void main() async {
  Get.put(ProductController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Xennial Store',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
      ),
      unknownRoute: GetPage(
        name: '/errorPage',
        page: () => ErrorPage(),
        transition: Transition.cupertino,
        transitionDuration: Duration(
          milliseconds: 600,
        ),
      ),
      initialRoute: '/homepage',
      getPages: routes,
    );
  }
}
