import 'package:flutter/material.dart';
import 'package:food_categories_app/screens/meals.dart';
import 'categories.dart';
import '../widgets/main_drawer.dart';
import 'filters.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/favorites_provider.dart';
import '../providers/filters_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedTab = 0;

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
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final avilableMeals = ref.watch(filterMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: avilableMeals,
    );
    if (_selectedTab == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
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
