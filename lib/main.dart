import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_router.dart';
import 'ui/pages/home_page.dart';
import 'ui/pages/product_page.dart';

void main() {
  runApp(ShopUiLabApp());
}

class ShopUiLabApp extends StatelessWidget {
  ShopUiLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop',
      initialRoute: AppRoutes.home,
      getPages: [
        GetPage(name: AppRoutes.home, page: () => HomePage()),
        GetPage(name: AppRoutes.product, page: () => ProductPage()),
      ],
    );
  }
}
