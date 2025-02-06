import 'package:car_api/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { light, dark, customLight, customDark, system }

class ThemeEvent {
  final AppTheme theme;
  ThemeEvent(this.theme);
}

class ThemeState {
  final ThemeData themeData;
  ThemeState(this.themeData);
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(lightTheme)) {
    on<ThemeEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      ThemeData selectedTheme;
      switch (event.theme) {
        case AppTheme.light:
          selectedTheme = lightTheme;
          break;
        case AppTheme.dark:
          selectedTheme = darkTheme;
          break;
        case AppTheme.customLight:
          selectedTheme = customLightTheme;
          break;
        case AppTheme.customDark:
          selectedTheme = customDarkTheme;
          break;
        case AppTheme.system:
        default:
          selectedTheme = lightTheme;
      }
      await prefs.setString('theme', event.theme.toString());
      emit(ThemeState(selectedTheme));
    });
  }
}

// import 'package:car_api/bloc/theme_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ThemeBloc extends Cubit<ThemeState> {
//   ThemeBloc() : super(ThemeState(isDarkTheme: false));

//   void toggleTheme() {
//     emit(ThemeState(isDarkTheme: !state.isDarkTheme));
//   }
// }
