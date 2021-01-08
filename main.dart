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
    
  }
  
  bool isExpired(DateTime foodExpireDate) {
    
  }

}

class _MyHomePageState extends State<MyHomePage> {
  final foods = <Food>[];
  final foodName = TextEditingController();
  final foodPosition = TextEditingController();
  final foodExpireDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Food in the fridge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
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
            TextField(
              controller: foodExpireDate,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter expiring date of food',
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
             foodPosition.text.isEmpty ||
             foodExpireDate.text.isEmpty) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Please enter some text 🥺'),
                );
              },
            );
          } else {
            setState(() {
              foods.add(food(foodName.text, foodPosition.text, foodExpireDate.text));
              foodName.clear();
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
