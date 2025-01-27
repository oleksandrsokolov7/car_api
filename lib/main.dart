import 'package:car_api/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();
    return MaterialApp(
      //  убрать отметку "debug"
      debugShowCheckedModeBanner: false,
      title: 'CarRapidApi',
      onGenerateRoute: appRouter.onGenerateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
