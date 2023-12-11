import 'package:flutter/material.dart';
import '/models/meal.dart';

class MealItemDetails extends StatelessWidget {
  const MealItemDetails({
    super.key,
    required this.meal,
  });

  final Meal meal;

  static const routeName = '/meal_details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
        ),
        body: Center(
          child: ListView(
            children: [
              Image.network(
                meal.imageUrl,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Ingredients',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              ...meal.ingredients.map((ingredient) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    ingredient,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 16),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ...meal.steps.map((step) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    step,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                );
              }).toList(),
              const SizedBox(height: 16),
            ],
          ),
        ));
  }
}
