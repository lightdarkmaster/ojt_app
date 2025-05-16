import 'package:flutter/material.dart';
import 'package:ojt_app/pages/ojt_hourSolver.dart';
import 'package:ojt_app/pages/timer.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),
            accountName: Text(
              'Sidebar Menu',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: null,
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'OJT',
                style: TextStyle(fontSize: 24.0, color: Colors.redAccent),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.calculate, color: Colors.redAccent),
            title: Text(
              'OJT Hours Solver',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HourSolver()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.timer, color: Colors.redAccent),
            title: Text(
              'Timer',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Timer()),
              );
            },
          ),
        ],
      ),
    );
  }
}

