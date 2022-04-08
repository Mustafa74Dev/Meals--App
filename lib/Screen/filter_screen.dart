import 'package:flutter/material.dart';
import '../Widgets/main_drawer.dart';

// ignore: must_be_immutable
class FilterScreen extends StatefulWidget {
  static const String routesName = '/filter-screen';

  Function saveFilters;
  Map<String, bool> currentFilterState;

  FilterScreen(this.currentFilterState, this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactosFree = false;

  Widget _buildSwitchTile(
    String title,
    String subTitle,
    bool isFilterSelected,
    var updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subTitle),
      value: isFilterSelected,
      onChanged: updateValue,
    );
  }

  @override
  void initState() {
    _glutenFree = widget.currentFilterState['gluten']!;
    _lactosFree = widget.currentFilterState['lactose']!;
    _vegan = widget.currentFilterState['vegan']!;
    _vegetarian = widget.currentFilterState['vegetarian']!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              final selectFilers = {
                'gluten': _glutenFree,
                'lactose': _lactosFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectFilers);
            },
            icon: Icon(
              Icons.save,
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meals selection',
              style: TextStyle(
                fontSize: 20,
                decoration: TextDecoration.underline,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                fontFamily: 'RobotoCondensed',
              ),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchTile(
                  'Gluten-free', 'Only include gluteen-free', _glutenFree,
                  (newValue) {
                setState(
                  () {
                    _glutenFree = newValue;
                  },
                );
              }),
              _buildSwitchTile(
                  'Vegetarian', 'Only include vesetarian-free', _vegetarian,
                  (newValue) {
                setState(
                  () {
                    _vegetarian = newValue;
                  },
                );
              }),
              _buildSwitchTile('Vegan', 'Only include vegan-free', _vegan,
                  (newValue) {
                setState(
                  () {
                    _vegan = newValue;
                  },
                );
              }),
              _buildSwitchTile(
                  'Lactos-free', 'Only include lactose-free', _lactosFree,
                  (newValue) {
                setState(
                  () {
                    _lactosFree = newValue;
                  },
                );
              }),
            ],
          ))
        ],
      ),
    );
  }
}
