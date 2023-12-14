import 'package:flutter/material.dart';
import 'package:food_categories_app/models/meal.dart';
import 'package:food_categories_app/widgets/meal_item.dart';
import 'package:food_categories_app/screens/meal_item_details.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.updateFavoriteStatus,
  });

  final void Function(Meal meal) updateFavoriteStatus;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealItemDetails(
        meal: meal,
        updateFavoriteStatus: updateFavoriteStatus,
      ),
    ));
  }

  final String? title;
  final List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(title: Text('Current category: $title'))
          : null,
      body: meals.isEmpty
          ? Center(
              child: Text(
                'No items found.',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = (constraints.maxWidth ~/ 400)
                    .clamp(1, double.infinity)
                    .toInt();
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
