import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal.dart';

class FavoreMealsNotifier extends StateNotifier<List<Meal>> {
  FavoreMealsNotifier() : super([]);

  bool toggleFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoreMealsNotifier, List<Meal>>((ref) {
  return FavoreMealsNotifier();
});
