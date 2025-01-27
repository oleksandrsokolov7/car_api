import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            // const Divider(
            //   color: Colors.black,
            //   thickness: 1,
            // ),
            ListTile(
              title: const Text('Makes'),
              //  selected: _selectedIndex == 0,
              onTap: () {
                Navigator.pushNamed(context, '/MakesForm');
                // Update the state of the app
                //  _onItemTapped(0);
                // Then close the drawer
                //
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              title: const Text('Car Models'),
              // selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                //  _onItemTapped(0);
                // Then close the drawer
                Navigator.pushNamed(context, '/CarModelsForm');
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              title: const Text('Cancel'),
              // selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                //  _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
