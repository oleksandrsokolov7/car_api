import 'package:car_api/crud/trim_crud.dart';
import 'package:car_api/models/req_res.dart';
import 'package:car_api/models/trim.dart';
import 'package:flutter/material.dart';

import 'package:car_api/bloc/block.dart';
import 'package:car_api/constants.dart';
import 'package:car_api/crud/model_car_crud.dart';

import 'package:car_api/widget/drawer_menu.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';

class TrimsForm extends StatefulWidget {
  const TrimsForm({super.key});

  @override
  _TrimsFormState createState() => _TrimsFormState();
}

class _TrimsFormState extends State<TrimsForm> {
  int _currentPage = 0;
  UniqueKey _paginatorKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    Widget central = context.read<DataCubit>().getTrimReqRes.message.isEmpty
        ? const Center(child: CircularProgressIndicator(color: Colors.blue))
        : GetCentralWidget(context.read<DataCubit>().getTrimReqRes);

    if (context.read<DataCubit>().getTrimReqRes.status == 0) {
      TrimCrud.getTrims('1', '2020', '0').then((value) {
        context.read<DataCubit>().setTrimReqRes(value);
        setState(() {});
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Trims', style: txt30.copyWith(color: Colors.black)),
        actions: _buildPopupMenu(context),
        elevation: 1,
      ),
      drawer: const DrawerMenu(),
      body: BlocBuilder<DataCubit, Keeper>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: central,
        ),
      ),
      bottomNavigationBar: Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        child: NumberPaginator(
          key: _paginatorKey,
          initialPage: _currentPage,
          numberPages: context.read<DataCubit>().getTrimReqRes.pages_total,
          onPageChange: (int index) {
            setState(() {
              _currentPage = index;
              TrimCrud.getTrims(
                (index + 1).toString(),
                context.read<DataCubit>().getYearFilter,
                context.read<DataCubit>().getMakesIdFilter,
              ).then((value) {
                context.read<DataCubit>().setTrimReqRes(value);
                setState(() {});
              });
            });
          },
        ),
      ),
    );
  }

  List<Widget> _buildPopupMenu(BuildContext context) {
    return [
      PopupMenuButton<int>(
        onSelected: (item) => _handleMenuSelection(context, item),
        itemBuilder: (context) => [
          const PopupMenuItem<int>(
            value: 0,
            child: Row(
              children: [
                Icon(Icons.calendar_month, color: Colors.black),
                SizedBox(width: 5),
                Text('Year')
              ],
            ),
          ),
          const PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: [
                Icon(Icons.car_repair_sharp, color: Colors.black),
                SizedBox(width: 5),
                Text('Makes')
              ],
            ),
          ),
        ],
      ),
    ];
  }

  void _handleMenuSelection(BuildContext context, int item) {
    if (item == 0) {
      Navigator.pushNamed(context, '/YearFilterForm',
              arguments: context.read<DataCubit>().getYearFilter)
          .then((value) {
        if (value != null) {
          context.read<DataCubit>().setYearFilter(value.toString());
          _fetchTrims();
        }
      });
    } else if (item == 1) {
      Navigator.pushNamed(context, '/MakesIdFilter',
              arguments: context.read<DataCubit>().getMakesIdFilter)
          .then((values) {
        if (values != null && values.toString().trim().isNotEmpty) {
          context.read<DataCubit>().setMakesIdFilter(values.toString());
          _fetchTrims();
        }
      });
    }
  }

  void _fetchTrims() {
    TrimCrud.getTrims(
      '1',
      context.read<DataCubit>().getYearFilter,
      context.read<DataCubit>().getMakesIdFilter,
    ).then((val) {
      context.read<DataCubit>().setTrimReqRes(val);
      setState(() {
        _currentPage = 0;
        _paginatorKey = UniqueKey();
      });
    });
  }

  Widget GetCentralWidget(ReqRes<Trim> result) {
    if (result.list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No Data', style: TextStyle(fontSize: 16)),
            if (result.status != 200)
              Text(result.message,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.separated(
      separatorBuilder: (context, index) =>
          const Divider(color: Colors.black12, thickness: 1),
      itemCount: result.list.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ExpansionTile(
            title: Text(result.list[index].name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            children: [
              _buildDetailTile('Makers', result.list[index].make_name),
              _buildDetailTile('Model', result.list[index].model_name),
              _buildDetailTile('Description', result.list[index].description),
              _buildDetailTile('Year', result.list[index].year.toString()),
              _buildDetailTile('MSRP', result.list[index].msrp.toString()),
              _buildDetailTile(
                  'Invoice', result.list[index].invoice.toString()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailTile(String title, String value) {
    return ListTile(
      title: Text('$title: $value', style: const TextStyle(fontSize: 14)),
    );
  }
}
