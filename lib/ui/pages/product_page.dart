import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/chips.dart';
import '../widgets/price_tag.dart';
import '../widgets/rating_stars.dart';
import '../widgets/product_card_small.dart';
import '../../routes/app_router.dart';
import '../../data/v3.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Map<String, dynamic> product;
  int imageIndex = 0;
  String? selectedColor;
  String? selectedSize;

  @override
  void initState() {
    super.initState();
    product = Get.arguments;

    final colors = product["colors"] as List<dynamic>? ?? [];
    final sizes = product["sizes"] as List<dynamic>? ?? [];

    selectedColor = colors.isNotEmpty ? colors.first["name"] : null;
    selectedSize = sizes.isNotEmpty ? sizes.first : null;
  }

  @override
  Widget build(BuildContext context) {
    final also = (details["relatedProducts"] as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(product["title"] ?? "Product"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.ios_share)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
        ],
      ),
      body: ListView(
        children: [
          // carousel imagini
          SizedBox(
            height: 420,
            child: PageView.builder(
              itemCount: (product["colors"]?[0]["images"] as List?)?.length ?? 1,
              onPageChanged: (i) => setState(() => imageIndex = i),
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product["colors"]?[0]["images"][i] ??
                        product["image"] ??
                        '',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              (product["colors"]?[0]["images"] as List?)?.length ?? 1,
                  (i) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == imageIndex ? Colors.black87 : Colors.black26,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          //  detalii produs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product["brand"] ?? "",
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black54)),
                      const SizedBox(height: 4),
                      Text(product["title"] ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          RatingStars(
                            rating: (product["rating"] ?? 0).toDouble(),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text('(${product["reviewsCount"] ?? 0})',
                              style: const TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                ),
                PriceTag(
                  price: (product["price"] ?? 0).toDouble(),
                  oldPrice: (product["oldPrice"] ?? 0).toDouble(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          if (product["sizes"] != null &&
              (product["sizes"] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  const Text('Size:',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  ...(product["sizes"] as List).map((s) => SizeChip(
                    label: s.toString(),
                    selected: s == selectedSize,
                    onTap: () => setState(() => selectedSize = s),
                  )),
                ],
              ),
            ),

          const SizedBox(height: 10),

          if (product["colors"] != null &&
              (product["colors"] as List).isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text('Color:',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  ...(product["colors"] as List).map((c) => ColorChipDot(
                    name: c["name"],
                    selected: c["name"] == selectedColor,
                    onTap: () =>
                        setState(() => selectedColor = c["name"]),
                  )),
                ],
              ),
            ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(product["description"] ?? ""),
          ),

          const SizedBox(height: 16),

          //buton
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Added to cart: ${product["title"]} — $selectedSize, $selectedColor'),
                ));
              },
              child: const Text('ADD TO CART'),
            ),
          ),

          const SizedBox(height: 16),
          const Divider(height: 24),

          //produse recomandate
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('You may also like',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 250,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: also.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) => ProductCardSmall(
                product: also[i],
                onTap: () => Get.off(() => const ProductPage(), arguments: also[i]),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
