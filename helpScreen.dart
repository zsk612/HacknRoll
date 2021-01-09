import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: <Widget>[
              Text(
                "Overrotten is an app specially designed for recording the grocery",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "To Use Overrotten:",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "STEP1: At home page, press 'add New Food' button",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "STEP2: At add page, fill in food info and press 'Add' button",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "STEP3: Go back to home page , press 'View my Inventory' button",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          )),
    );
  }
}
