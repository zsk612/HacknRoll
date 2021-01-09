import 'package:flutter/material.dart';
import 'package:over_rotten/status.dart';

import 'foodScreen.dart';
import 'main.dart';
import 'searchFood.dart';

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
              showSearch(context: context, delegate: SearchFood(foods))
                  .then(onGoBack);
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
            trailing: Text(foods[index].getStatus().toString().split(".")[1],
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: displayColor(foods[index].getStatus()),
                )),
            hoverColor: Colors.blue[100],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodScreen(food: foods[index]),
                ),
              ).then(onGoBack);
            },
          );
        },
      ),
    );
  }

  onGoBack(dynamic value) {
    setState(() {
      foods.sort(
          (a, b) => a.getDaysUntilExpire().compareTo(b.getDaysUntilExpire()));
    });
    MyHomePageState.saveData();
  }

  Color displayColor(Status expireState) {
    Color colorState;
    switch (expireState) {
      case Status.EXPIRED:
        {
          colorState = Colors.red;
        }
        break;
      case Status.EXPIRING:
        {
          colorState = Colors.orange;
        }
        break;
      case Status.FRESH:
        {
          colorState = Colors.green;
        }
        break;
      default:
        {
          colorState = Colors.grey;
        }
        break;
    }
    return colorState;
  }
}
