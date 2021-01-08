import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

enum Status {
  fresh,
  expiring, // 3 days before expired
  expired
}

class Food {
  String foodName;
  double foodNumber;
  String foodPosition;
  DateTime foodExpireDate;
  final DateTime currentDate = DateTime.now();

  Food(String foodName, double foodNumber, String foodPosition,
      DateTime foodExpireDate) {
    this.foodName = foodName;
    this.foodNumber = foodNumber;
    this.foodPosition = foodPosition;
    this.foodExpireDate = foodExpireDate;
  }

  String get name {
    return foodName;
  }

  double get number {
    return foodNumber;
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

  void set number(double foodNumber) {
    number = foodNumber;
  }

  void set position(String foodPosition) {
    position = foodPosition;
  }

  void set expireDate(DateTime foodExpireDate) {
    expireDate = foodExpireDate;
  }

  Status getStatus() {
    final diffDt = foodExpireDate.difference(currentDate);
    if (diffDt.inDays >= 3) {
      return Status.fresh;
    } else if (diffDt.inDays < 0) {
      return Status.expired;
    } else {
      return Status.expiring;
    }
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                    decoration:
                        new InputDecoration(labelText: "Enter your number"),
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
                            foods.add(Food(
                                foodName.text,
                                double.parse(foodNumber.text),
                                foodPosition.text,
                                selectedDate.toLocal()));
                            foodName.clear();
                            foodNumber.clear();
                            foodPosition.clear();
                            selectedDate = DateTime.now();
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
              leading: Text("Food Number:"),
              trailing: Text(food.foodNumber.toString()),
            ),
            ListTile(
              leading: Text("Food Position:"),
              trailing: Text(food.foodPosition),
            ),
            ListTile(
              leading: Text("Food Status:"),
              trailing: Text(food.getStatus().toString().split(".")[1]),
            ),
            TextField(
              controller: foodNumber,
              decoration: new InputDecoration(labelText: "Edit amount of Food"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
            ),
            ListTile(
              leading: Text("Expiring Date:"),
              trailing: Text("${food.expireDate.toLocal()}".split(' ')[0]),
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  food.foodNumber = double.parse(foodNumber.text);
                  foodNumber.clear();
                });
              },
              child: Text(
                'Save changes',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              color: Colors.greenAccent,
            ),
            RaisedButton(
              onPressed: () {
                print("item deleted");
              },
              child: Text(
                'Delete',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              color: Colors.greenAccent,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchFood extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult;
  
  @override
  // Not used
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Food> suggestionList = [];
    if (query.isEmpty) {
      suggestionList = [];
    } else {
      suggestionList.addAll(foods.where(
        (element) => element.foodName.contains(query),
      ));
    }
    
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title:Text(
            suggestionList[index].foodName.toString(),
          ),
          onTap: () {
            selectedResult = suggestionList[index].foodName;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodScreen(food: suggestionList[index]),
              ),
            );
          },
        );
      },
    );
  }
  
  final List<Food> foods;
  SearchFood(this.foods);
}

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("List Food"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchFood(foods));
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(foods[index].foodName),
            trailing: Text(foods[index].getStatus().toString().split(".")[1]),
            hoverColor: Colors.blue[50],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodScreen(food: foods[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
