import 'package:flutter/material.dart';
import 'package:meals_app/Widgets/meal_item.dart';
import 'package:meals_app/dummy_data.dart';

// ignore: must_be_immutable
class MealsDetailsScreen extends StatelessWidget {
  static const routeName = '/meals-details';

  Function toggelHandler;
  Function isFavorite;
  MealsDetailsScreen(this.toggelHandler, this.isFavorite);

  //const MealsDetailsScreen({Key? key}) : super(key: key);

  Widget buildSection(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      width: double.infinity,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealsDetails = ModalRoute.of(context)!.settings.arguments as DataPass;
    final selectedMeals =
        DUMMY_MEALS.firstWhere((meals) => meals.id == mealsDetails.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedMeals.title!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          softWrap: true,
          overflow: TextOverflow.fade,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                    height: 300,
                    width: double.infinity,
                    child: Image.network(
                      selectedMeals.imageUrl!,
                      fit: BoxFit.cover,
                    )),
                buildSection(context, 'Ingredients'),
                buildContainer(ListView.builder(
                  itemBuilder: (ctx, index) => Card(
                    color: Theme.of(context).accentColor,
                    elevation: 4,
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Text(selectedMeals.ingredients![index])),
                  ),
                  itemCount: selectedMeals.ingredients!.length,
                )),
                buildSection(context, 'Steps To Fllow'),
                SizedBox(
                  height: 5,
                ),
                buildContainer(ListView.builder(
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${index + 1}'),
                        ),
                        title: Text(selectedMeals.steps![index]),
                      ),
                      Divider(),
                    ],
                  ),
                  itemCount: selectedMeals.steps!.length,
                )),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealsDetails.id) ? Icons.star : Icons.star_border,
        ),
        onPressed: () => toggelHandler(mealsDetails.id)
        // onPressed: () {
        //   Navigator.of(context).pop(mealsDetails.id);
        // }
        ,
      ),
    );
  }
}
