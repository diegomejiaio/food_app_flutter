import 'package:flutter/material.dart';
import 'package:food_categories_app/models/meal.dart';
import 'package:food_categories_app/widgets/meal_item.dart';
import 'package:food_categories_app/screens/meal_item_details.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealItemDetails(
        meal: meal,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Scaffold(
        appBar: widget.title != null
            ? AppBar(title: Text('Current category: ${widget.title}'))
            : null,
        body: widget.meals.isEmpty
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
                    itemCount: widget.meals.length,
                    itemBuilder: (context, index) {
                      return MealItem(
                        meal: widget.meals[index],
                        onSelectedMeal: () {
                          _selectMeal(context, widget.meals[index]);
                        },
                      );
                    },
                  );
                },
              ),
      ),
      builder: (context, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOutCirc),
          ),
          child: child),
    );
  }
}
