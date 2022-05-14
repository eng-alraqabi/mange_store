import 'package:flutter/material.dart';
class BottomBar extends StatelessWidget {
  final  VoidCallback search_tap,refresh_tap;
  BottomBar(this.search_tap,this.refresh_tap);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 1,
      color: Colors.lightGreen[900],
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
          Spacer(),
          IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.white,
              onPressed: refresh_tap),
          IconButton(
            icon: Icon(Icons.info),
            color: Colors.white,
            onPressed: search_tap,
          ),
        ],
      ),
    );

  }

}