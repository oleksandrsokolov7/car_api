import 'package:car_api/bloc/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
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

  // Загрузка сохранённой темы из SharedPreferences
  Future<void> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('theme') ?? 'AppTheme.light';
    setState(() {
      _selectedTheme = _getAppThemeFromString(themeString);
    });
  }

  // Преобразование строки в AppTheme
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
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          RadioListTile<AppTheme>(
            title: Text('Light Theme'),
            value: AppTheme.light,
            groupValue: _selectedTheme,
            onChanged: (AppTheme? value) {
              setState(() {
                _selectedTheme = value;
              });
              themeBloc.add(ThemeEvent(value!));
            },
          ),
          RadioListTile<AppTheme>(
            title: Text('Dark Theme'),
            value: AppTheme.dark,
            groupValue: _selectedTheme,
            onChanged: (AppTheme? value) {
              setState(() {
                _selectedTheme = value;
              });
              themeBloc.add(ThemeEvent(value!));
            },
          ),
          RadioListTile<AppTheme>(
            title: Text('Custom Light Theme'),
            value: AppTheme.customLight,
            groupValue: _selectedTheme,
            onChanged: (AppTheme? value) {
              setState(() {
                _selectedTheme = value;
              });
              themeBloc.add(ThemeEvent(value!));
            },
          ),
          RadioListTile<AppTheme>(
            title: Text('Custom Dark Theme'),
            value: AppTheme.customDark,
            groupValue: _selectedTheme,
            onChanged: (AppTheme? value) {
              setState(() {
                _selectedTheme = value;
              });
              themeBloc.add(ThemeEvent(value!));
            },
          ),
          RadioListTile<AppTheme>(
            title: Text('System Theme'),
            value: AppTheme.system,
            groupValue: _selectedTheme,
            onChanged: (AppTheme? value) {
              setState(() {
                _selectedTheme = value;
              });
              themeBloc.add(ThemeEvent(value!));
            },
          ),
        ],
      ),
    );
  }
}
