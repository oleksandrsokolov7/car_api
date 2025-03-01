import 'package:car_api/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppTheme? _selectedTheme;

  @override
  void initState() {
    super.initState();
    _loadSavedTheme();
  }

  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme') ?? 'AppTheme.light';
    setState(() {
      _selectedTheme = _getAppThemeFromString(themeString);
    });
  }

  AppTheme _getAppThemeFromString(String themeString) {
    switch (themeString) {
      case 'AppTheme.light':
        return AppTheme.light;
      case 'AppTheme.dark':
        return AppTheme.dark;
      case 'AppTheme.customLight':
        return AppTheme.customLight;
      case 'AppTheme.customDark':
        return AppTheme.customDark;
      case 'AppTheme.system':
      default:
        return AppTheme.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ListView(
        children: <Widget>[
          _buildThemeOption('Light Theme', AppTheme.light, themeBloc),
          _buildThemeOption('Dark Theme', AppTheme.dark, themeBloc),
          _buildThemeOption(
              'Custom Light Theme', AppTheme.customLight, themeBloc),
          _buildThemeOption(
              'Custom Dark Theme', AppTheme.customDark, themeBloc),
          _buildThemeOption('System Theme', AppTheme.system, themeBloc),
        ],
      ),
    );
  }

  Widget _buildThemeOption(String title, AppTheme theme, ThemeBloc themeBloc) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: RadioListTile<AppTheme>(
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        value: theme,
        groupValue: _selectedTheme,
        activeColor: Colors.blue,
        onChanged: (AppTheme? value) async {
          setState(() {
            _selectedTheme = value;
          });
          themeBloc.add(ThemeEvent(value!));

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('theme', value.toString());
        },
      ),
    );
  }
}
