import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:get/get.dart';

import 'helper/dependencies.dart' as dep;
import 'routes/route_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            // home: SignInPage(),
            initialRoute: RouteHelper.getSplashPage(),
            getPages: RouteHelper.routes,
          );
        });
      },
    );
  }
}
