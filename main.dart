import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ListScreen.dart';
import 'food.dart';

final foods = <Food>[];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
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

  final foodName = TextEditingController();
  final foodPosition = TextEditingController();
  final foodNumber = TextEditingController();
  //final foodExpireDate = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void initState(){
    initSharePreferences();

    super.initState();
  }

  initSharePreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  static void saveData(){
    List<String> spList = foods.map((food)=>json.encode(food.toMap())).toList();
    sharedPreferences.setStringList('list', spList);
    //print(spList);
  }

  void loadData(){
    List<String> spList = sharedPreferences.getStringList('list');
    var tempFoodList = <Food>[];
    tempFoodList = spList.map((food) =>Food.fromMap(json.decode(food))).toList();

    //pass stored data to final list foods
    for(var foodData in tempFoodList ){
      foods.add(foodData);
    }

    setState(() {});
  }

  Future<Null> _selectedDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2030, 12));
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Food in the fridge'),
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
              bottom: 60.0,
              left: 10.0,
              right: 10.0,
              child: Column(
                children: <Widget>[
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    onPressed: () => _selectedDate(context),
                    child: Text(
                      'Select date',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.greenAccent,
                  ),
                  TextField(
                    controller: foodName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter food name',
                    ),
                  ),
                  TextField(
                    controller: foodNumber,
                    decoration: new InputDecoration(labelText: "Enter your number"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                  TextField(
                    controller: foodPosition,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter position of food in the fridge',
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                        child: Text('List'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListScreen()),
                          );
                        }),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () {
                        if (foodName.text.isEmpty ||
                            foodPosition.text.isEmpty ||
                            foodNumber.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    'Please enter full detail of the food 🥺'),
                              );
                            },
                          );
                        } else {
                          setState(() {
                            foods.add(Food(foodName.text, double.parse(foodNumber.text), foodPosition.text,
                                selectedDate.toLocal()));
                            foodName.clear();
                            foodNumber.clear();
                            foodPosition.clear();
                            selectedDate = DateTime.now();
                            saveData();
                          });
                        }
                      },
                      child: Icon(Icons.add),
                    ),
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


