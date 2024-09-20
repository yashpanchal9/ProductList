import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? 'Product Details',style: const TextStyle(fontSize:20)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              SizedBox(
                width: double.infinity,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.thumbnail ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(product.title ?? '',
                  style: const TextStyle(fontSize:20)),
              const SizedBox(height: 8),
              Text(
                product.description ?? '',
                style: const TextStyle(fontSize:15),
              ),
              const SizedBox(height: 16),
              if (product.reviews != null && product.reviews!.isNotEmpty) ...[
                const Text(
                  'Reviews',
                  style: TextStyle(fontSize:20),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: product.reviews!.take(3).map((review) {
                    final formattedDate = review.date != null
                        ? DateFormat('MMM dd, yyyy')
                            .format(DateTime.parse(review.date!))
                        : 'No Date';
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(
                              12.0), // Add padding inside the card
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              '${review.reviewerName ?? 'Anonymous'} - $formattedDate',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Rating: ${review.rating ?? 0} stars',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  review.comment ?? '',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
