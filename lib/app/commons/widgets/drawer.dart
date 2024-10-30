import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/core/commons/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image(
                        image: AssetImage('images/IES.webp'),
                        width: 50,
                        height: 50),
                    Text('IES PIK'),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    Text('Back'),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.check_box_sharp),
                SizedBox(width: 5),
                Text('Event Check In')
              ],
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/');
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.settings),
                SizedBox(
                  width: 5,
                ),
                Text('Printer Configuration')
              ],
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/printer_config');
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 5),
                Text('Logout')
              ],
            ),
            onTap: () {
              removeToken().then((_) {
                Navigator.pop(context);
              });
            },
          ),
        ],
      ),
    );
  }
}
