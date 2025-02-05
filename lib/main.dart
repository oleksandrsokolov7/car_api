import 'package:car_api/app_router.dart';
import 'package:car_api/bloc/block.dart';
import 'package:car_api/bloc/theme_bloc.dart';
import 'package:car_api/bloc/theme_state.dart';
import 'package:car_api/constants.dart';
import 'package:car_api/models/peferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          print(state.isDarkTheme);
          int y = 0;
          return MaterialApp(
            title: 'Car Api',
            theme: state.isDarkTheme ? darkTheme : lightTheme,
            onGenerateRoute: _appRouter.onGenerateRoute,
            //  initialRoute: '/SettingsPage',
          );
        },
      ),
    );
  }
}



/*
// class MyApp extends StatefulWidget {
//   MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<DataCubit, Keeper>(
//       builder: (context, state) {
//         ThemeData _theme = state.isDarkTheme ? darkTheme : lightTheme;
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           //   theme: _theme,
//           title: 'CarRapidApi',
//           onGenerateRoute: AppRouter().onGenerateRoute,
//         );
//       },
//     );
//   }
// }
*/