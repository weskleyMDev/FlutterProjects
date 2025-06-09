import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealItem extends StatefulWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onFavoriteToggle,
    required this.isFavorite,
  });

  final Meal meal;
  final void Function(Meal) onFavoriteToggle;
  final bool Function(Meal) isFavorite;

  @override
  State<MealItem> createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.meal.title),
      subtitle: Text(widget.meal.complexityText),
      leading: InkWell(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) {
              return AlertDialog(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                scrollable: true,
                content: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            widget.meal.imgUrl,
                            fit: BoxFit.cover,
                            height: 250.0,
                          ),
                        ),
                        Positioned(
                          left: 10.0,
                          bottom: 10.0,
                          child: Container(
                            width: 250.0,
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.black54,
                            child: Column(
                              children: [
                                Text(
                                  widget.meal.title,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.schedule),
                              SizedBox(width: 8.0),
                              Text(
                                "${widget.meal.duration} minutes",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                          child: VerticalDivider(
                            thickness: 2.0,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.monetization_on_outlined),
                              SizedBox(width: 8.0),
                              Text(
                                widget.meal.costText,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        child: CircleAvatar(backgroundImage: NetworkImage(widget.meal.imgUrl)),
      ),
      trailing: IconButton(
        icon: Icon(
          widget.isFavorite(widget.meal) ? Icons.star_outlined : Icons.star_border_outlined,
          color: widget.isFavorite(widget.meal)
              ? const Color.fromARGB(255, 239, 191, 4)
              : Colors.grey,
        ),
        iconSize: 30.0,
        onPressed: () {
          widget.onFavoriteToggle(widget.meal);
        },
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 200.0,
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView.builder(
                  itemCount: widget.meal.ingredients.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 10.0,
                        ),
                        child: Text(
                          "\u2022 ${widget.meal.ingredients[index]}",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Container(
                height: 200.0,
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView.builder(
                  itemCount: widget.meal.steps.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Theme.of(context).cardColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 12.0,
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                          title: Text(
                            widget.meal.steps[index],
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
