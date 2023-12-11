import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelectedMeal,
  });

  String get complexityText {
    switch (meal.complexity) {
      case Complexity.simple:
        return 'Simple';
      case Complexity.challenging:
        return 'Challenging';
      case Complexity.hard:
        return 'Hard';
      default:
        return 'Unknown';
    }
  }

  String get affordabilityText {
    switch (meal.affordability) {
      case Affordability.affordable:
        return 'Affordable';
      case Affordability.pricey:
        return 'Pricey';
      case Affordability.luxurious:
        return 'Luxurious';
      default:
        return 'Unknown';
    }
  }

  final void Function() onSelectedMeal;

  final Meal meal;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onSelectedMeal,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: NetworkImage(meal.imageUrl),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: -1,
                    right: 0,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      color: Colors.black54,
                      child: Text(
                        meal.title,
                        maxLines: 2,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 16),
                      const SizedBox(width: 4),
                      Text('${meal.duration} min',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              )),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.hardware, size: 16),
                      const SizedBox(width: 4),
                      Text(complexityText,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              )),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.attach_money, size: 16),
                      const SizedBox(width: 4),
                      Text(affordabilityText,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
