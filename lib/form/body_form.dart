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

    return ListView.separated(
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.black, thickness: 1),
      itemCount: result.list.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: ExpansionTile(
            title: Text(
                "${result.list[index].trim.make_name} ${result.list[index].trim.model_name}"),
            children: [
              _buildListTile('Type', result.list[index].type),
              _buildListTile('Doors', result.list[index].doors),
              _buildListTile('Length', result.list[index].length),
              _buildListTile('Seats', result.list[index].seats),
              _buildListTile('Height', result.list[index].height),
              _buildListTile('Wheel Base', result.list[index].wheel_base),
              _buildListTile('Front Track', result.list[index].front_track),
              _buildListTile('Rear Track', result.list[index].rear_track),
              _buildListTile(
                  'Ground Clearance', result.list[index].ground_clearance),
              _buildListTile(
                  'Cargo Capacity', result.list[index].cargo_capacity),
              _buildListTile(
                  'Max Cargo Capacity', result.list[index].max_cargo_capacity),
              _buildListTile('Curb Weight', result.list[index].curb_weight),
              _buildListTile('Gross Weight', result.list[index].gross_weight),
              _buildListTile('Max Payload', result.list[index].max_payload),
              _buildListTile('Max Towing Capacity',
                  result.list[index].max_towing_capacity),
              ExpansionTile(
                title: Text('Trim: ${result.list[index].trim.name}'),
                subtitle: Text(
                    "${result.list[index].trim.make_name} ${result.list[index].trim.model_name}"),
                children: [
                  _buildListTile('Year', result.list[index].trim.year),
                  _buildListTile(
                      'Description', result.list[index].trim.description),
                  _buildListTile('MSRP', result.list[index].trim.msrp),
                  _buildListTile('Invoice', result.list[index].trim.invoice),
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
