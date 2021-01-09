import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addScreen.dart';
import 'helpScreen.dart';
import 'listScreen.dart';
import 'food.dart';

final foods = <Food>[];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primarySwatch: Colors.indigo, hintColor: Colors.grey[400]),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static SharedPreferences sharedPreferences;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    initSharePreferences();

    super.initState();
  }

  initSharePreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  static void saveData() {
    List<String> spList =
        foods.map((food) => json.encode(food.toMap())).toList();
    sharedPreferences.setStringList('list', spList);
    //print(spList);
  }

  void loadData() {
    List<String> spList = sharedPreferences.getStringList('list');
    var tempFoodList = <Food>[];
    tempFoodList =
        spList.map((food) => Food.fromMap(json.decode(food))).toList();

    //pass stored data to final list foods
    for (var foodData in tempFoodList) {
      foods.add(foodData);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Overrotten'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 20.0,
              left: 10.0,
              right: 10.0,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: double.infinity,
                      height: 240.0,
                      child: new FlatButton(
                        color: Colors.indigo,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.indigo)),
                        child: Text(
                          'View My Inventory',
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListScreen()),
                          );
                        },
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 240.0,
                      child: new FlatButton(
                        color: Colors.indigo,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.indigo)),
                        child: Text(
                          'Add New Food',
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddScreen()),
                          );
                        },
                      )),
                  SizedBox(
                      child: new FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HelpScreen()),
                      );
                    },
                    child: Icon(Icons.question_answer),
                    backgroundColor: Colors.indigo,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
