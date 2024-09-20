import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'screens/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner : false,
        title: 'Flutter Product List',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const ProductListScreen(),
      ),
    );
  }
}
