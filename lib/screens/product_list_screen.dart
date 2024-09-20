import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/loading_widget.dart';
import '../widgets/product_item.dart';
import 'category_filter_dialog.dart';
import 'product_detail_page.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  ProductListScreenState createState() => ProductListScreenState();
}

class ProductListScreenState extends State<ProductListScreen> {


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products',style: TextStyle(fontSize:20)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              // Open filter dialog
              showDialog(
                context: context,
                builder: (context) => const CategoryFilterDialog(),
              );
            },
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const LoadingWidget();
          } else if (provider.error.isNotEmpty) {
            return Center(child: Text(provider.error));
          } else {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.categories.length,
                    itemBuilder: (context, index) {
                      final category = provider.categories[index];
                      return GestureDetector(
                        onTap: () {
                          provider.filterByCategories(
                            provider.selectedCategories.contains(category)
                                ? provider.selectedCategories
                                    .where((c) => c != category)
                                    .toList()
                                : [...provider.selectedCategories, category],
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          child: Text(
                            category.capitalize(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  provider.selectedCategories.contains(category)
                                      ? Colors.black
                                      : Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(

                  child: ListView.builder(
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                product: provider.products[index],
                              ),
                            ),
                          );
                        },
                        child: ProductItem(product: provider.products[index]),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}


extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}