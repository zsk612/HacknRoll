import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Help'),
        ),
        body: Column(
          children: <Widget>[
            Text(
              "STEP1: At home page, press 'add food' button",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "STEP2: At add page, enter food info and press 'add' button",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              "STEP3: Go back to home page , press 'my fridge' button",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ));
  }
}
