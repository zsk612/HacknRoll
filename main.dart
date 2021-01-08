import 'dart:async';
import 'package:flutter/material.dart';

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
  _MyHomePageState createState() => _MyHomePageState();
}

class Food {
  String foodName;
  String foodPosition;
  DateTime foodExpireDate;
  final DateTime currentDate = DateTime.now();

  Food(String foodName, String foodPosition, DateTime foodExpireDate) {
    this.foodName = foodName;
    this.foodPosition = foodPosition;
    this.foodExpireDate = foodExpireDate;
  }

  String get name {
    return foodName;
  }

  String get position {
    return foodPosition;
  }

  DateTime get expireDate {
    return foodExpireDate;
  }

  void set name(String foodName) {
    name = foodName;
  }

  void set position(String foodPosition) {
    position = foodPosition;
  }

  void set expireDate(DateTime foodExpireDate) {
    expireDate = foodExpireDate;
  }

  bool isNearExpire(DateTime foodExpireDate) {
    return true;
  }

  bool isExpired(DateTime foodExpireDate) {
    return true;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final foods = <Food>[];
  final foodName = TextEditingController();
  final foodPosition = TextEditingController();
  //final foodExpireDate = TextEditingController();

  DateTime selectedDate = DateTime.now();

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
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
              controller: foodPosition,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter position of food in the fridge',
              ),
            ),
            for (var food in foods)
              ListTile(
                leading: Text(food.name),
                trailing: OutlinedButton(
                  onPressed: () => setState(() => foods.remove(food)),
                  child: Text('Done'),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (foodName.text.isEmpty ||
              foodPosition.text.isEmpty) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Please enter full detail of the food 🥺'),
                );
              },
            );
          } else {
            setState(() {
              foods.add(
                  Food(foodName.text, foodPosition.text, selectedDate.toLocal()));
              foodName.clear();
              foodPosition.clear();
              selectedDate = DateTime.now();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
