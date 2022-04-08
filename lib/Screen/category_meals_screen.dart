import 'package:flutter/material.dart';

import 'package:meals_app/Models/meal.dart';
import 'package:meals_app/Widgets/category_item.dart';

import '../Widgets/meal_item.dart';

// ignore: must_be_immutable
class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  List<Meal> mealList;
  CategoryMealsScreen({
    Key? key,
    required this.mealList,
  }) : super(key: key);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  String? categoryId;
  List<Meal>? displayMeals;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final mealsData =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    categoryId = mealsData.id!;
    categoryTitle = mealsData.title!;
    displayMeals = widget.mealList.where((meals) {
      return meals.categories!.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMealItem(String mealId) {
    setState(() {
      displayMeals!.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final categoryTitle = routesArd['title'];
    // final id = routesArd['id'];
    // print(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle!,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayMeals![index].id!,
            title: displayMeals![index].title!,
            imageUrl: displayMeals![index].imageUrl!,
            duartion: displayMeals![index].duration!,
            affordability: displayMeals![index].affordability!,
            complexity: displayMeals![index].complexity!,
            //removeItem: _removeMealItem,
          );
        },
        itemCount: displayMeals!.length,
      ),
    );
  }
}
