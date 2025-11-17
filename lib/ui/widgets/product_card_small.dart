import 'package:flutter/material.dart';

class ProductCardSmall extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onTap;

  const ProductCardSmall({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              product["image"],
              width: 120,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product["name"] ?? "",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            product["brand"] ?? "",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            "\$${product["price"] ?? product["newPrice"]}",
            style: const TextStyle(color: Colors.blueAccent),
          ),
        ],
      ),
    );
  }
}
