import 'package:flutter/material.dart';
import 'package:food_categories_app/widgets/category_grid_item.dart';
import 'package:food_categories_app/data/dummy_data.dart';
import 'package:food_categories_app/models/category.dart';
import 'package:food_categories_app/screens/meals.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const routeName = '/categories';

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealsScreen(
        title: category.title,
        meals: filteredMeals,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 800
              ? 3
              : MediaQuery.of(context).size.width > 200
                  ? 2
                  : 1,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        children: availableCategories
            .map((category) => CategoryGridItem(
                category: category,
                onSelectedCategory: () {
                  _selectCategory(context, category);
                }))
            .toList(),
      ),
    );
  }
}