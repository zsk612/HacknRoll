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
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(foods[index].foodName),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
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
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Column(
//           children: <Widget>[
//             for (var food in foods)
//               ListTile(
//                 leading: Text(food.name),
//                 trailing: OutlinedButton(
//                   onPressed: () => setState(() => foods.remove(food)),
//                   child: Text('Remove'),
//                 ),
//               ),
//           ],
//         ),
//       ),
    );
  }
}
