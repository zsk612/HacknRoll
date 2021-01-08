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
