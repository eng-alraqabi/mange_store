import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mange_store/constants.dart';

class PublicDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.lightGreen[900],
            ),
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Text(
                  "s_mainscreen",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading:
            Icon(Icons.account_balance_wallet, color: Colors.green[900]),
            title: Text(
              'الحسابات',
              style: TextStyle(
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              // change app state...
              // Navigator.pop(context); // close the drawer
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context)=> Sales_Invoice()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.add_chart,
              color: Colors.green[900],
            ),
            title: Text(
              'الفواتير',
              style: TextStyle(
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            onTap: () {
              // change app state...
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.green[900]),
            title: Text(
              'الأعدادات',
              style: TextStyle(
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            onTap: () {
              // change app state...
              Navigator.pop(context); // close the drawer
            },
          ),
          Divider(
            color: Colors.green[900],
          ),
          ListTile(
            leading: Icon(Icons.account_box_outlined, color: Colors.green[900]),
            title: Text(
              'الأسماء',
              style: TextStyle(
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            onTap: () {
              // change app state...
              Navigator.pop(context); // close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.green[900]),
            title: Text(
              'خروج',
              style: TextStyle(
                color: Colors.green[900],
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            onTap: () {
              SystemNavigator.pop();
              Navigator.pop(context); // close the drawer
            },
          ),
        ],
      ),
    );
  }
}
