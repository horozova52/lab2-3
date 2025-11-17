import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../routes/app_router.dart';
import '../widgets/section_header.dart';
import '../widgets/product_tile.dart';
import '../widgets/product_card_small.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // controllerul GetX
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.header['title'] ?? 'Loading...')),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_bag_outlined)),
        ],
      ),

      body: Obx(() {
        if (controller.sections.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final header = controller.header;
        final sections = controller.sections;

        final sale = (sections[0]["items"] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();

        final fresh = (sections[1]["items"] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            //banner din JSON
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 7,
                    child: Image.network(
                      header["bannerImage"],
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 16,
                    child: Text(
                      header["title"] ?? '',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            SectionHeader(title: 'Sale', onSeeAll: () {}),

            SizedBox(
              height: 280,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: sale.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, i) => ProductTile(
                  product: sale[i],
                  onTap: () {
                    // navigare cu Get
                    Get.toNamed(AppRoutes.product, arguments: sale[i]);

                  },
                ),
              ),
            ),

            const SizedBox(height: 8),
            SectionHeader(title: 'New', onSeeAll: () {}),

            SizedBox(
              height: 260,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: fresh.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, i) => ProductCardSmall(
                  product: fresh[i],
                  onTap: () {
                    Get.toNamed(AppRoutes.product, arguments: fresh[i]);
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        );
      }),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (_) {},
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Likes'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
