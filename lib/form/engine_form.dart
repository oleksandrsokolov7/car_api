import 'package:car_api/constants.dart';
import 'package:car_api/crud/engine_crud.dart';
import 'package:car_api/models/engine.dart';
import 'package:car_api/models/req_res.dart';
import 'package:car_api/widget/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:car_api/bloc/block.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';

class EngineForm extends StatefulWidget {
  const EngineForm({super.key});

  @override
  _EngineFormState createState() => _EngineFormState();
}

class _EngineFormState extends State<EngineForm> {
  int _currentPage = 0;
  UniqueKey _paginatorKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    Widget central = context.read<DataCubit>().getEngineReqRes.message.isEmpty
        ? const CircularProgressIndicator(color: Colors.blue)
        : Center(
            child: GetCentralWidget(context.read<DataCubit>().getEngineReqRes),
          );

    if (context.read<DataCubit>().getEngineReqRes.status == 0) {
      EngineCrud.getEngines('1', '2020', '0').then((value) {
        context.read<DataCubit>().setEngineReqRes(value);
        setState(() {});
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu_rounded, color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text('Engines', style: txt30.copyWith(color: Colors.black)),
        actions: <Widget>[
          PopupMenuButton<int>(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onSelected: (item) => _handleMenuSelection(item, context),
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Icon(Icons.calendar_month, color: Colors.black),
                    SizedBox(width: 5),
                    Text('Year'),
                  ],
                ),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    Icon(Icons.car_repair, color: Colors.black),
                    SizedBox(width: 5),
                    Text('Makes'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: const DrawerMenu(),
      body: BlocBuilder<DataCubit, Keeper>(
        builder: (context, state) => Center(child: central),
      ),
      bottomNavigationBar: Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        child: NumberPaginator(
          key: _paginatorKey,
          initialPage: _currentPage,
          numberPages: context.read<DataCubit>().getEngineReqRes.pages_total,
          onPageChange: (int index) {
            setState(() {
              _currentPage = index;
              EngineCrud.getEngines(
                (index + 1).toString(),
                context.read<DataCubit>().getYearFilter,
                context.read<DataCubit>().getMakesIdFilter,
              ).then((value) {
                context.read<DataCubit>().setEngineReqRes(value);
                setState(() {});
              });
            });
          },
        ),
      ),
    );
  }

  void _handleMenuSelection(int item, BuildContext context) {
    if (item == 0) {
      Navigator.pushNamed(context, '/YearFilterForm',
              arguments: context.read<DataCubit>().getYearFilter)
          .then((value) {
        if (value != null) {
          context.read<DataCubit>().setYearFilter(value.toString());
          _refreshEngines();
        }
      });
    } else if (item == 1) {
      Navigator.pushNamed(context, '/MakesIdFilter',
              arguments: context.read<DataCubit>().getMakesIdFilter)
          .then((value) {
        if (value != null) {
          context.read<DataCubit>().setMakesIdFilter(value.toString());
          _refreshEngines();
        }
      });
    }
  }

  void _refreshEngines() {
    EngineCrud.getEngines(
      '1',
      context.read<DataCubit>().getYearFilter,
      context.read<DataCubit>().getMakesIdFilter,
    ).then((value) {
      context.read<DataCubit>().setEngineReqRes(value);
      setState(() {
        _currentPage = 0;
        _paginatorKey = UniqueKey();
      });
    });
  }

  Widget GetCentralWidget(ReqRes<Engine> result) {
    if (result.list.isEmpty) {
      return Center(
        child: Text(
          result.status == 200 ? 'No Data' : result.message,
          style: txt15,
        ),
      );
    }

    // Группировка по модели (make_name + model_name)
    var groupedEngines = <String, List<Engine>>{};
    for (var engine in result.list) {
      String key = "${engine.trim.make_name} ${engine.trim.model_name}";
      if (!groupedEngines.containsKey(key)) {
        groupedEngines[key] = [];
      }
      groupedEngines[key]!.add(engine);
    }

    return ListView.builder(
      itemCount: groupedEngines.keys.length,
      itemBuilder: (context, index) {
        String modelName = groupedEngines.keys.elementAt(index);
        List<Engine> enginesForModel = groupedEngines[modelName]!;

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: ExpansionTile(
            title: Text(
              modelName,
              style: txt20,
            ),
            children: enginesForModel.map((engine) {
              return Column(
                children: [
                  _buildDetailTile('Engine Type', engine.engine_type),
                  _buildDetailTile('Fuel Type', engine.fuel_type),
                  _buildDetailTile('Cylinders', engine.cylinders),
                  _buildDetailTile('Horsepower (HP)', engine.horsepower_hp),
                  _buildDetailTile('Horsepower RPM', engine.horsepower_rpm),
                  _buildDetailTile('Torque (ft-lbs)', engine.torque_ft_lbs),
                  _buildDetailTile('Torque RPM', engine.torque_rpm),
                  _buildDetailTile('Valves', engine.valves),
                  _buildDetailTile('Valve Timing', engine.valve_timing),
                  _buildDetailTile('Cam Type', engine.cam_type),
                  _buildDetailTile('Drive Type', engine.drive_type),
                  _buildDetailTile('Transmission', engine.transmission),
                  ExpansionTile(
                    title: Text('Trim: ${engine.trim.name}', style: txt15),
                    children: [
                      _buildDetailTile('Year', engine.trim.year),
                      _buildDetailTile('Description', engine.trim.description),
                      _buildDetailTile('MSRP', engine.trim.msrp),
                      _buildDetailTile('Invoice', engine.trim.invoice),
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildDetailTile(String title, dynamic value) {
    return ListTile(
      title: Text(
        '$title: $value',
        style: txt15,
      ),
    );
  }
}
