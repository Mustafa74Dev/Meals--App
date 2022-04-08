import 'package:flutter/material.dart';
import 'package:meals_app/Models/meal.dart';
import 'package:meals_app/Widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favourites;

  FavoriteScreen(this.favourites);

  @override
  Widget build(BuildContext context) {
    if (favourites.isEmpty) {
      return Container(
        child: Center(
          child: Text('Hello'),
        ),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favourites[index].id!,
            title: favourites[index].title!,
            imageUrl: favourites[index].imageUrl!,
            duartion: favourites[index].duration!,
            affordability: favourites[index].affordability!,
            complexity: favourites[index].complexity!,
          );
        },
        itemCount: favourites.length,
      );
    }
  }
}
