import 'package:car_api/bloc/block.dart';
import 'package:car_api/bloc/theme_bloc.dart';
import 'package:car_api/form/body_form.dart';
import 'package:car_api/form/car_models_form.dart';
import 'package:car_api/form/engine_form.dart';
import 'package:car_api/form/makes_form.dart';
import 'package:car_api/form/makes_id_filter.dart';

import 'package:car_api/form/setting_page.dart';
import 'package:car_api/form/trims_form.dart';
import 'package:car_api/form/vin_model_form.dart';
import 'package:car_api/form/year_filter_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final DataCubit cubit = DataCubit(Keeper());
  final ThemeBloc thBlock = ThemeBloc();
  int selectIndex = 0;

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/MakesForm':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: MakesForm(),
          ),
        );

      case '/CarModelsForm':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: CarModelsForm(),
          ),
        );

      case '/TrimsForm':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: TrimsForm(),
          ),
        );

      case '/EngineForm':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: EngineForm(),
          ),
        );

      case '/BodyForm':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: BodyForm(),
          ),
        );

      case '/VinModelForm':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: VinModelForm(),
          ),
        );

      //  YearFilterForm
      case '/YearFilterForm':
        final String year = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => YearFilterForm(year: year),
        );
      //   MakesIdFilter

      case '/MakesIdFilter':
        final String makerId = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: MakesIdFilter(
              makerId: makerId,
            ),
          ),
        );

      case '/SettingsPage':
        return MaterialPageRoute(builder: (_) => SettingsPage());

      default:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: VinModelForm(),
          ),
        );
    }
  }
}
