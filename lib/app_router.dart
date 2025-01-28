import 'package:car_api/block.dart';
import 'package:car_api/form/car_models_form.dart';
import 'package:car_api/form/makes_form.dart';
import 'package:car_api/form/makes_id_filter.dart';
import 'package:car_api/form/trims_form.dart';
import 'package:car_api/form/year_filter_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  final DataCubit cubit = DataCubit(Keeper());
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

      //  YearFilterForm
      case '/YearFilterForm':
        final String _year = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => YearFilterForm(year: _year),
        );
      //   MakesIdFilter

      case '/MakesIdFilter':
        final String _makerId = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: MakesIdFilter(
              makerId: _makerId,
            ),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: cubit,
            child: CarModelsForm(),
          ),
        );
    }
  }
}
