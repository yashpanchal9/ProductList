// services/api_service.dart
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com/products';

  Future<ProductResponse> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // print('API response: $data');

      return ProductResponse.fromJson(data);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
