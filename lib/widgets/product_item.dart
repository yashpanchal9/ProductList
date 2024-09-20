import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        leading: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: 110,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.thumbnail ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if ((product.discountPercentage ?? 0) > 0)
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  color: Colors.red,
                  child: Text(
                    '${product.discountPercentage}% OFF',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          product.title ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          product.brand ?? '',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Text(
          '\$${product.price?.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        isThreeLine: true,
      ),
    );
  }
}
