import 'package:car_api/app_router.dart';
import 'package:car_api/form/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/theme_bloc.dart';
// import 'pages/home_page.dart';
// import 'pages/settings_page.dart';
// import 'themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final themeString = prefs.getString('theme') ?? 'AppTheme.light';
  AppTheme initialTheme;
  switch (themeString) {
    case 'AppTheme.light':
      initialTheme = AppTheme.light;
      break;
    case 'AppTheme.dark':
      initialTheme = AppTheme.dark;
      break;
    case 'AppTheme.customLight':
      initialTheme = AppTheme.customLight;
      break;
    case 'AppTheme.customDark':
      initialTheme = AppTheme.customDark;
      break;
    case 'AppTheme.system':
    default:
      initialTheme = AppTheme.system;
  }
  runApp(MyApp(initialTheme: initialTheme));
}

class MyApp extends StatelessWidget {
  final AppTheme initialTheme;
  final AppRouter _appRouter = AppRouter();

  MyApp({required this.initialTheme});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc()..add(ThemeEvent(initialTheme)),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Theme App',
            theme: state.themeData,
            onGenerateRoute: _appRouter.onGenerateRoute,
            // initialRoute: '/',
            // routes: {
            //   '/': (context) => HomePage(),
            //   '/settings': (context) => SettingsPage(),
            // },
          );
        },
      ),
    );
  }
}







// import 'package:car_api/app_router.dart';
// import 'package:car_api/bloc/block.dart';
// import 'package:car_api/bloc/theme_bloc.dart';
// import 'package:car_api/bloc/theme_state.dart';
// import 'package:car_api/constants.dart';
// import 'package:car_api/models/peferences.dart';
// import 'package:car_api/themes/app_themes.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(
//     MyApp(),
//   );
// }

// class MyApp extends StatelessWidget {
//   final AppRouter _appRouter = AppRouter();

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ThemeBloc(),
//       child: BlocBuilder<ThemeBloc, ThemeState>(
//         builder: (context, state) {
//           print(state.isDarkTheme);
//           int y = 0;
//           return MaterialApp(
//             title: 'Car Api',
//             theme: state.isDarkTheme ? darkTheme : lightTheme,
            
//             onGenerateRoute: _appRouter.onGenerateRoute,
//             //  initialRoute: '/SettingsPage',
//           );
//         },
//       ),
//     );
//   }
// }



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