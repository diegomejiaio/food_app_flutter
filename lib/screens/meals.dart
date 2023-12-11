import 'package:flutter/material.dart';
import 'package:food_categories_app/models/meal.dart';
import 'package:food_categories_app/widgets/meal_item.dart';
import 'package:food_categories_app/screens/meal_item_details.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  static const routeName = '/meals';

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => MealItemDetails(
        meal: meal,
      ),
    ));
  }

  final String title;
  final List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current category: $title'),
      ),
      body: meals.isEmpty
          ? const Center(
              child: Text('No meals found'),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth ~/
                    400; // calculate the number of items in a row
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    return MealItem(
                      meal: meals[index],
                      onSelectedMeal: () {
                        _selectMeal(context, meals[index]);
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
