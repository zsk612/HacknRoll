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
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.greenAccent,
            ),
            RaisedButton(
                    onPressed: () {
                      print("item deleted");
                    },
                    child: Text(
                      'Delete',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    color: Colors.greenAccent,
            ),
          ],
        ),
      ),
    );
  }
}