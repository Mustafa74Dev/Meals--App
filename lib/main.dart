import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import '../dummy_data.dart';

import './Screen/tabs_screen.dart';
import './Screen/meals_details_screen.dart';
import './Screen/category_meals_screen.dart';
import 'Screen/filter_screen.dart';
import '../Models/meal.dart';

// import './Screen/categories_screen.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favourtieMeals = [];

  void _setFilters(Map<String, bool> isFilters) {
    setState(() {
      _filters = isFilters;

      _availableMeal = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree!) {
          return false;
        }

        if (_filters['lactose']! && !meal.isLactoseFree!) {
          return false;
        }

        if (_filters['vegan']! && !meal.isVegan!) {
          return false;
        }

        if (_filters['vegetarian']! && !meal.isVegetarian!) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favourtieMeals.indexWhere((meal) => meal.id == mealId);
    print('existingIndex => $existingIndex');

    if (existingIndex >= 0) {
      setState(() {
        _favourtieMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favourtieMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favourtieMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(
          255,
          254,
          229,
          1,
        ),
        fontFamily: 'Ralway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              headline3: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                color: Colors.black.withOpacity(0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: MyHomePage(title: 'Meals App'),
      // home: CategoriesScreen(),

      routes: {
        '/': (ctx) => TabsScreen(_favourtieMeals),
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(mealList: _availableMeal),
        MealsDetailsScreen.routeName: (ctx) =>
            MealsDetailsScreen(_toggleFavourite, _isMealFavorite),
        FilterScreen.routesName: (ctx) => FilterScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // if (settings.name == '/meal-detail') {
        //   return ...;
        // } else if (settings.name == '/something-else') {
        //   return ...;
        // }
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(
          builder: (ctx) => CategoryMealsScreen(mealList: _availableMeal),
        );
      },
    );
  }
}
