import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'listScreen.dart';
import 'food.dart';
import 'main.dart';

class AddScreen extends StatefulWidget {
  @override
  AddScreenState createState() => AddScreenState();
}

class AddScreenState extends State<AddScreen> {
  //static SharedPreferences sharedPreferences;

  final foodName = TextEditingController();
  final foodPosition = TextEditingController();
  final foodNumber = TextEditingController();
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
        title: Text('Add Food to the fridge'),
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
                  TextField(
                    controller: foodName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter food name',
                      // hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: foodNumber,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter amount of food',
                      // hintStyle: TextStyle(color: Colors.white),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: foodPosition,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter store position',
                      // hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  RaisedButton(
                    onPressed: () => _selectedDate(context),
                    child: Text(
                      'Select expiring date',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.indigo,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      color: Colors.white,
                      textColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.indigo)),
                      child: Text('Add'),
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
                            foods.add(Food(
                                foodName.text,
                                double.parse(foodNumber.text),
                                foodPosition.text,
                                selectedDate.toLocal()));

                            foods.sort((a, b) => a
                                .getDaysUntilExpire()
                                .compareTo(
                                    b.getDaysUntilExpire())); //sort the list

                            foodName.clear();
                            foodNumber.clear();
                            foodPosition.clear();
                            selectedDate = DateTime.now();
                            MyHomePageState.saveData();
                          });
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                        color: Colors.indigo,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.indigo)),
                        child: Text('List'),
                        onPressed: () {
                          foods.sort((a, b) => a
                              .getDaysUntilExpire()
                              .compareTo(b.getDaysUntilExpire()));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListScreen()),
                          );
                        }),
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
