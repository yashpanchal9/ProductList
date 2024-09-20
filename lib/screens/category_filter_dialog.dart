import 'package:ecartdemo/screens/product_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class CategoryFilterDialog extends StatefulWidget {
  const CategoryFilterDialog({super.key});

  @override
  CategoryFilterDialogState createState() => CategoryFilterDialogState();
}

class CategoryFilterDialogState extends State<CategoryFilterDialog> {
  late List<String> _selectedCategories;

  @override
  void initState() {
    super.initState();
    _selectedCategories =
        Provider.of<ProductProvider>(context, listen: false).selectedCategories;
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<ProductProvider>(context).categories;

    return AlertDialog(
      title: const Text('Filter by Category',style: TextStyle(fontSize:20)),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CheckboxListTile(
              title: Text(category.capitalize(),style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),),
              value: _selectedCategories.contains(category),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _selectedCategories.add(category);
                  } else {
                    _selectedCategories.remove(category);
                  }
                });
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Provider.of<ProductProvider>(context, listen: false)
                .filterByCategories(_selectedCategories);
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
        TextButton(
          onPressed: () {
            Provider.of<ProductProvider>(context, listen: false).resetFilters();
            Navigator.of(context).pop();
          },
          child: const Text('Reset'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
