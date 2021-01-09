import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  // final foodName = TextEditingController();
  // final foodPosition = TextEditingController();
  // final foodNumber = TextEditingController();

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

  // Future<Null> _selectedDate(BuildContext context) async {
  //   final DateTime selected = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(2020, 1),
  //       lastDate: DateTime(2030, 12));
  //   if (selected != null && selected != selectedDate)
  //     setState(() {
  //       selectedDate = selected;
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OverRotten'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Stack(
          children: <Widget>[
//             Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('images/new_york.jpg'),
//                   fit: BoxFit.fitHeight,
//                 ),
//               ),
//             ),
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
                          'View My Fridge',
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
                          'Add new item',
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

                  // TextField(
                  //   controller: foodName,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     hintText: 'Enter food name',
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // TextField(
                  //   controller: foodNumber,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     hintText: 'Enter food number',
                  //   ),
                  //   keyboardType: TextInputType.number,
                  //   inputFormatters: <TextInputFormatter>[
                  //     FilteringTextInputFormatter.digitsOnly
                  //   ], // Only numbers can be entered
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // TextField(
                  //   controller: foodPosition,
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     hintText: 'Enter position of food in the fridge',
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Text(
                  //   "${selectedDate.toLocal()}".split(' ')[0],
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  // RaisedButton(
                  //   onPressed: () => _selectedDate(context),
                  //   child: Text(
                  //     'Select date',
                  //     style: TextStyle(
                  //         color: Colors.white, fontWeight: FontWeight.bold),
                  //   ),
                  //   color: Colors.indigo,
                  // ),
                  //
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: FlatButton(
                  //     color: Colors.white,
                  //     textColor: Colors.indigo,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(18.0),
                  //         side: BorderSide(color: Colors.indigo)),
                  //     child: Text('Add'),
                  //     onPressed: () {
                  //       if (foodName.text.isEmpty ||
                  //           foodPosition.text.isEmpty ||
                  //           foodNumber.text.isEmpty) {
                  //         showDialog(
                  //           context: context,
                  //           builder: (context) {
                  //             return AlertDialog(
                  //               title: Text(
                  //                   'Please enter full detail of the food 🥺'),
                  //             );
                  //           },
                  //         );
                  //       } else {
                  //         setState(() {
                  //           foods.add(Food(foodName.text, double.parse(foodNumber.text), foodPosition.text,
                  //               selectedDate.toLocal()));
                  //           foodName.clear();
                  //           foodNumber.clear();
                  //           foodPosition.clear();
                  //           selectedDate = DateTime.now();
                  //           saveData();
                  //         });
                  //       }
                  //     },
                  //   ),
                  // ),
                  //
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: FlatButton(
                  //       color: Colors.indigo,
                  //       textColor: Colors.white,
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(18.0),
                  //           side: BorderSide(color: Colors.indigo)),
                  //       child: Text('List'),
                  //       onPressed: () {
                  //         foods.sort((a, b) => a.getDaysUntilExpire().compareTo(b.getDaysUntilExpire()));
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => ListScreen()),
                  //         );
                  //       }),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
