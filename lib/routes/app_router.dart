import 'package:flutter/material.dart';
import '../ui/pages/home_page.dart';
import '../ui/pages/product_page.dart';

class AppRoutes {
  static const home = '/';
  static const product = '/product';
}
//
// class AppRouter {
//   static Route<dynamic> onGenerateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case AppRoutes.home:
//         return MaterialPageRoute(builder: (_) => HomePage());
//       case AppRoutes.product:
//         final product = settings.arguments as Map<String, dynamic>;
//         return MaterialPageRoute(
//           builder: (_) => ProductPage(product: product),
//         );
//
//       default:
//         return MaterialPageRoute(
//           builder: (_) => const Scaffold(
//             body: Center(child: Text('Route not found')),
//           ),
//         );
//     }
//   }
//}
