import 'package:flutter/material.dart';
import 'package:mange_store/constants.dart';

class Search extends SearchDelegate<String> {
  final List<String> listExample;
  Search(this.listExample);
  late String selectresult;

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          }),
      FloatingActionButton(
          mini: true,
          child: Icon(Icons.person_add_sharp),
          onPressed: () {
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => InsertCastmer()));
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null!;
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme;
  }

  @override
  void close(BuildContext context, result) {
    // TODO: implement close
    super.close(context, result);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = listExample //In the true case
        : suggestionList.addAll(listExample.where(
      // In the false case
          (element) => element.contains(query),
    ));

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: KaccentColor,
            selectedTileColor: KprimaryColor,
            title: Text(
              suggestionList[index],
            ),
            leading: query.isEmpty
                ? Icon(
              Icons.access_time,
              color: KaccentColor,
            )
                : Icon(
              Icons.person,
              color: KprimaryColor,
            ),
            onTap: () {
              selectresult = suggestionList[index];
              //showResults(context);
              //result_serach(selectresult);
              close(context, selectresult);
            },
          );
        },
      ),
    );
  }
}
