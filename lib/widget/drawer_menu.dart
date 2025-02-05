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
            ListTile(
              title: const Text('Makes'),
              onTap: () {
                Navigator.pushNamed(context, '/MakesForm');
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              title: const Text('Car Models'),
              onTap: () {
                Navigator.pushNamed(context, '/CarModelsForm');
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              title: const Text('Trims'),
              onTap: () {
                Navigator.pushNamed(context, '/TrimsForm');
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              title: const Text('Engine'),
              onTap: () {
                Navigator.pushNamed(context, '/EngineForm');
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              title: const Text('Body'),
              onTap: () {
                Navigator.pushNamed(context, '/BodyForm');
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            ListTile(
              title: const Text('Vin Model'),
              onTap: () {
                Navigator.pushNamed(context, '/VinModelForm');
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),

            ListTile(
              title: const Text('Setting'),
              onTap: () {
                Navigator.pushNamed(context, '/SettingsPage');
              },
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            //

            ListTile(
              title: const Text('Cancel'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
