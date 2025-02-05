import 'package:car_api/bloc/block.dart';
import 'package:car_api/bloc/theme_state.dart';
import 'package:car_api/constants.dart';
import 'package:car_api/widget/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/theme_bloc.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu_rounded),
            );
          },
        ),
        centerTitle: true,
        title: Text('Settings Page'),
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return SwitchListTile(
              title: Text('Dark Theme'),
              value: state.isDarkTheme,
              onChanged: (value) {
                int y = 0;
                context.read<ThemeBloc>().toggleTheme();
              },
            );
          },
        ),
      ),
    );
  }
}

// class SettingsPage extends StatefulWidget {
//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   bool isDart = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Settings Page'),
//       ),
//       body: BlocBuilder<DataCubit, Keeper>(
//         builder: (context, state) {
//           return Center(
//             child: SwitchListTile(
//               title: Text(
//                 'Dark Theme',
//                 style: txt30,
//               ),
//               value: context.read<DataCubit>().getIsDarkTheme,
//               onChanged: (value) {
//                 print(value);
//                 setState(() {
//                   context.read<DataCubit>().setIsDarkTheme(value);
//                   isDart = value;
//                 });
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
