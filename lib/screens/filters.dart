import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  bool _gluterFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _veganFilterSet = false;
  var _vegetarianFilterSet = false;

  @override
  void initState() {
    super.initState();
    _gluterFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your filters'),
        ),
        // drawer: MainDrawer(
        //   onSelectedScreen: (identifier) {
        //     Navigator.pop(context);
        //     if (identifier == 'meals') {
        //       setState(() {
        //         Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        //           return const TabsScreen();
        //         }));
        //       });
        //     }
        //   },
        // ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop({
              Filter.glutenFree: _gluterFreeFilterSet,
              Filter.lactoseFree: _lactoseFreeFilterSet,
              Filter.vegan: _veganFilterSet,
              Filter.vegetarian: _vegetarianFilterSet,
            });
            return Future.value(false);
          },
          child: Column(
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
              SwitchListTile(
                value: _lactoseFreeFilterSet,
                onChanged: (isCheck) {
                  setState(() {
                    _lactoseFreeFilterSet = !_lactoseFreeFilterSet;
                  });
                },
                title: Text(
                  'Lactose-free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  'Only include lactose-free meals.',
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
              SwitchListTile(
                value: _veganFilterSet,
                onChanged: (isCheck) {
                  setState(() {
                    _veganFilterSet = !_veganFilterSet;
                  });
                },
                title: Text(
                  'Vegan',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  'Only include vegan meals.',
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
              SwitchListTile(
                value: _vegetarianFilterSet,
                onChanged: (isCheck) {
                  setState(() {
                    _vegetarianFilterSet = !_vegetarianFilterSet;
                  });
                },
                title: Text(
                  'Vegetarian',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  'Only include vegetarian meals.',
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
          ),
        ));
  }
}
