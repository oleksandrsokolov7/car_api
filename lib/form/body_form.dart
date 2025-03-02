import 'package:car_api/constants.dart';
import 'package:car_api/crud/body_crud.dart';
import 'package:car_api/models/body.dart';
import 'package:car_api/models/req_res.dart';
import 'package:car_api/widget/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:car_api/bloc/block.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';

class BodyForm extends StatefulWidget {
  const BodyForm({super.key});

  @override
  _BodyFormState createState() => _BodyFormState();
}

class _BodyFormState extends State<BodyForm> {
  int _currentPage = 0;
  UniqueKey _paginatorKey = UniqueKey();

  // Функция для фильтрации повторяющихся элементов
  List<Body> removeDuplicates(List<Body> list) {
    Set<String> seen = Set();
    List<Body> uniqueList = [];
    for (var body in list) {
      if (!seen.contains(body.trim.make_name)) {
        // Проверяем по названию модели
        seen.add(body.trim.make_name);
        uniqueList.add(body);
      }
    }
    return uniqueList;
  }

  @override
  Widget build(BuildContext context) {
    Widget central = context.read<DataCubit>().getBodyReqRes.message.isEmpty
        ? const CircularProgressIndicator(color: Colors.blue)
        : Center(
            child: GetCentralWidget(context.read<DataCubit>().getBodyReqRes),
          );

    if (context.read<DataCubit>().getBodyReqRes.status == 0) {
      BodyCrud.getBodyes('1', '2020', '0').then((value) {
        context.read<DataCubit>().setBodyReqRes(value);
        setState(() {});
      });
    }

    return Scaffold(
      extendBodyBehindAppBar: true, // Чтобы содержимое было за AppBar
      drawer: const DrawerMenu(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Body Form',
                style: TextStyle(color: Colors.white),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: BlocBuilder<DataCubit, Keeper>(
              builder: (context, state) => Center(child: central),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        child: NumberPaginator(
          key: _paginatorKey,
          initialPage: _currentPage,
          numberPages: context.read<DataCubit>().getBodyReqRes.pages_total,
          onPageChange: (index) => _onPageChange(index, context),
        ),
      ),
    );
  }

  void _handleMenuSelection(int item, BuildContext context) {
    if (item == 0) {
      String yearFilter = context.read<DataCubit>().getYearFilter;
      Navigator.pushNamed(context, '/YearFilterForm', arguments: yearFilter)
          .then((value) {
        if (value != null) {
          context.read<DataCubit>().setYearFilter(value.toString());
          _fetchBodyData(context);
        }
      });
    } else if (item == 1) {
      String makesIdFilter = context.read<DataCubit>().getMakesIdFilter;
      Navigator.pushNamed(context, '/MakesIdFilter', arguments: makesIdFilter)
          .then((value) {
        if (value != null && value.toString().trim().isNotEmpty) {
          context.read<DataCubit>().setMakesIdFilter(value.toString());
          _fetchBodyData(context);
        }
      });
    }
  }

  void _fetchBodyData(BuildContext context) {
    BodyCrud.getBodyes(
      '1',
      context.read<DataCubit>().getYearFilter,
      context.read<DataCubit>().getMakesIdFilter,
    ).then((value) {
      context.read<DataCubit>().setBodyReqRes(value);
      setState(() {
        _currentPage = 0;
        _paginatorKey = UniqueKey();
      });
    });
  }

  void _onPageChange(int index, BuildContext context) {
    setState(() {
      _currentPage = index;
      BodyCrud.getBodyes(
        (index + 1).toString(),
        context.read<DataCubit>().getYearFilter,
        context.read<DataCubit>().getMakesIdFilter,
      ).then((value) {
        context.read<DataCubit>().setBodyReqRes(value);
        setState(() {});
      });
    });
  }

  Widget GetCentralWidget(ReqRes<Body> result) {
    if (result.list.isEmpty) {
      return Center(
        child: Text(
          result.status == 200 ? 'No Data' : result.message,
          style: txt15,
        ),
      );
    }

    // Убираем дубликаты с помощью фильтрации
    List<Body> uniqueList = removeDuplicates(result.list);

    return ListView.separated(
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.black, thickness: 1),
      itemCount: uniqueList.length, // Используем уникальный список
      itemBuilder: (context, index) {
        final body = uniqueList[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: ExpansionTile(
            title: Text("${body.trim.make_name} ${body.trim.model_name}"),
            children: [
              PropertyTile(title: 'Type', value: body.type),
              PropertyTile(title: 'Doors', value: body.doors),
              PropertyTile(title: 'Length', value: body.length),
              PropertyTile(title: 'Seats', value: body.seats),
              PropertyTile(title: 'Height', value: body.height),
              PropertyTile(title: 'Wheel Base', value: body.wheel_base),
              PropertyTile(title: 'Front Track', value: body.front_track),
              PropertyTile(title: 'Rear Track', value: body.rear_track),
              PropertyTile(
                  title: 'Ground Clearance', value: body.ground_clearance),
              PropertyTile(title: 'Cargo Capacity', value: body.cargo_capacity),
              PropertyTile(
                  title: 'Max Cargo Capacity', value: body.max_cargo_capacity),
              PropertyTile(title: 'Curb Weight', value: body.curb_weight),
              PropertyTile(title: 'Gross Weight', value: body.gross_weight),
              PropertyTile(title: 'Max Payload', value: body.max_payload),
              PropertyTile(
                  title: 'Max Towing Capacity',
                  value: body.max_towing_capacity),
              ExpansionTile(
                title: Text('Trim: ${body.trim.name}'),
                subtitle:
                    Text("${body.trim.make_name} ${body.trim.model_name}"),
                children: [
                  PropertyTile(title: 'Year', value: body.trim.year),
                  PropertyTile(
                      title: 'Description', value: body.trim.description),
                  PropertyTile(title: 'MSRP', value: body.trim.msrp),
                  PropertyTile(title: 'Invoice', value: body.trim.invoice),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  ListTile _buildListTile(String title, dynamic value) {
    return ListTile(
      title: Text('$title: $value', style: txt15),
    );
  }
}

// Виджет для вывода свойств модели
class PropertyTile extends StatelessWidget {
  final String title;
  final dynamic value;

  const PropertyTile({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$title: $value', style: txt15),
    );
  }
}
