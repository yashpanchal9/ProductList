import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<String> _categories = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  String _error = '';
  List<String> _selectedCategories = [];

  List<Product> get products =>
      _filteredProducts.isEmpty ? _products : _filteredProducts;
  List<String> get categories => _categories;
  bool get isLoading => _isLoading;
  String get error => _error;
  List<String> get selectedCategories => _selectedCategories;

  final ApiService _apiService = ApiService();

  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      notifyListeners();
      ProductResponse response = await _apiService.fetchProducts();
      _products = response.products ?? [];
      _categories = _extractCategories(_products);
      _filteredProducts = _products;
      _isLoading = false;
    } catch (e) {
      _error = 'Failed to load products';
      _isLoading = false;
    }
    notifyListeners();
  }

  List<String> _extractCategories(List<Product> products) {
    final categories = products
        .map((p) => p.category)
        .where((c) => c != null && c.isNotEmpty)
        .cast<String>()
        .toSet()
        .toList();
    return categories;
  }

  void filterByCategories(List<String> categories) {
    _selectedCategories = categories;
    if (categories.isEmpty) {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products
          .where((product) => categories.contains(product.category))
          .toList();
    }
    notifyListeners();
  }

  void resetFilters() {
    _selectedCategories = [];
    _filteredProducts = _products;
    notifyListeners();
  }
}
