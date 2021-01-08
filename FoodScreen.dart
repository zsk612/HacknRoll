class FoodScreen extends StatelessWidget {
  // Declare a field that holds the Todo.
  final Food food;

  // In the constructor, require a Todo.
  FoodScreen({Key key, @required this.food}) : super(key: key);

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
                leading: Text("Expiring Date:"),
                trailing: Text("${food.expireDate.toLocal()}".split(' ')[0]),
            ),
          ],
        ),
      ),
    );
  }
}
