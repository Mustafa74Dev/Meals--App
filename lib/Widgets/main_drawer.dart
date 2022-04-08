import 'package:flutter/material.dart';
import 'package:meals_app/Screen/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget listWidgets(String title, IconData icons, VoidCallback tapHandler) {
      return ListTile(
        leading: Icon(
          icons,
          size: 26,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        onTap: tapHandler,
      );
    }

    return Drawer(
      child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Text(
              'Mustafa Shaikh - Flutter',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
                color: Colors.black87,
              ),
            ),
          ),
          listWidgets(
            'Meals',
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          listWidgets(
            'Settings',
            Icons.settings,
            () {
              Navigator.pushReplacementNamed(context, FilterScreen.routesName,
                  arguments: 'hello');
            },
          ),
        ],
      ),
    );
  }
}
