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
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            for (var food in foods)
              ListTile(
                leading: Text(food.name),
                trailing: OutlinedButton(
                  onPressed: () => setState(() => foods.remove(food)),
                  child: Text('Remove'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}