import 'package:car_api/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Cubit<ThemeState> {
  ThemeBloc() : super(ThemeState(isDarkTheme: false));

  void toggleTheme() {
    emit(ThemeState(isDarkTheme: !state.isDarkTheme));
  }
}
