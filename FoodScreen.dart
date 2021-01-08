import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:over_rotten/ListScreen.dart';

import 'food.dart';
import 'main.dart';

class FoodScreen extends StatefulWidget {
  final Food food;
  @override
  _FoodScreenState createState() => _FoodScreenState(food);
  // In the constructor, require a food.
  FoodScreen({Key key, @required this.food}) : super(key: key);
}

class _FoodScreenState extends State<FoodScreen> {
  Food food;
  _FoodScreenState(this.food);
  final foodNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(food.foodName),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Text("Food Name:"),
              trailing: Text(food.foodName),
            ),
            ListTile(
              leading: Text("Food Position:"),
              trailing: Text(food.foodPosition),
            ),
            ListTile(
              leading: Text("Food Status:"),
              trailing: Text(food.getStatus().toString().split(".")[1]),
            ),
            ListTile(
              leading: Text("Expiring Date:"),
              trailing: Text("${food.expireDate.toLocal()}".split(' ')[0]),
            ),
            ListTile(
              leading: Text("Food Number:"),
              trailing: Text(food.foodNumber.toString()),
            ),
            TextField(
              controller: foodNumber,
              decoration: new InputDecoration(labelText: "Edit amount of Food"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  food.foodNumber = double.parse(foodNumber.text);
                  foodNumber.clear();
                  MyHomePageState.saveData();
                });
              },
              child: Text(
                'Save changes',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              color: Colors.green,
            ),
            RaisedButton(
              onPressed: () {
                //print("item deleted");
                foods.remove(food);
                MyHomePageState.saveData();
                //Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                'Delete',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}
