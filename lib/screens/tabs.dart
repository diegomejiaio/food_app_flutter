import 'package:flutter/material.dart';
import 'package:food_categories_app/screens/meals.dart';
import 'categories.dart';
import '../data/dummy_data.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import 'filters.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedTab = 0;
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _updateFavoriteStatus(Meal meal) {
    setState(() {
      final index = dummyMeals.indexWhere((element) => element.id == meal.id);
      dummyMeals[index].isFavorite =
          dummyMeals[index].isFavorite ? false : true;
    });
  }

  void _selectTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  void _selectDrawerOption(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'meals') {
      setState(() {
        _selectedTab = 0;
      });
    } else if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(currentFilters: _selectedFilters),
        ),
      );
      if (result != null) {
        setState(() {
          _selectedFilters = result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final avilableMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      updateFavoriteStatus: _updateFavoriteStatus,
      availableMeals: avilableMeals,
    );
    if (_selectedTab == 1) {
      activePage = MealsScreen(
        meals: avilableMeals.where((meal) => meal.isFavorite).toList(),
        updateFavoriteStatus: _updateFavoriteStatus,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals App'),
      ),
      drawer: MainDrawer(onSelectedScreen: _selectDrawerOption),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectTab(index);
        },
        currentIndex: _selectedTab,
        backgroundColor: const Color.fromARGB(58, 41, 44, 45),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Icon(Icons.fastfood_outlined)),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Icon(Icons.star),
            ),
            label: 'Favorites',
          ),
        ],
      ),
      body: activePage,
    );
  }
}
