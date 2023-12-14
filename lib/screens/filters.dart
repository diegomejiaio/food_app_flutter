import 'package:flutter/material.dart';
import 'package:food_categories_app/screens/tabs.dart';
import 'package:food_categories_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var _gluterFreeFilterSet = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your filters'),
        ),
        drawer: MainDrawer(
          onSelectedScreen: (identifier) {
            Navigator.pop(context);
            if (identifier == 'meals') {
              setState(() {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const TabsScreen();
                }));
              });
            }
          },
        ),
        body: Column(
          children: [
            SwitchListTile(
              value: _gluterFreeFilterSet,
              onChanged: (isCheck) {
                setState(() {
                  _gluterFreeFilterSet = isCheck;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 22,
              ),
            ),
          ],
        ));
  }
}
