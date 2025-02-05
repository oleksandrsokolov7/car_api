import 'package:car_api/crud/trim_crud.dart';
import 'package:car_api/models/req_res.dart';
import 'package:car_api/models/trim.dart';
import 'package:flutter/material.dart';

import 'package:car_api/bloc/block.dart';
import 'package:car_api/constants.dart';
import 'package:car_api/crud/model_car_crud.dart';

import 'package:car_api/widget/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';

class TrimsForm extends StatefulWidget {
  const TrimsForm({Key? key}) : super(key: key);

  @override
  _TrimsFormState createState() => _TrimsFormState();
}

class _TrimsFormState extends State<TrimsForm> {
  int _currentPage = 0; // Переменная для хранения текущей страницы
  UniqueKey _paginatorKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    Widget central = context.read<DataCubit>().getTrimReqRes.message.isEmpty
        ? CircularProgressIndicator(
            color: Colors.blue,
          )
        : Center(
            child: GetCentralWidget(context.read<DataCubit>().getTrimReqRes),
          );

    if (context.read<DataCubit>().getTrimReqRes.status == 0) {
      TrimCrud.getTrims('1', '2020', '0').then(
        (value) {
          print(value);
          context.read<DataCubit>().setTrimReqRes(value);

          central = GetCentralWidget(context.read<DataCubit>().getTrimReqRes);

          setState(() {});
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu_rounded),
            );
          },
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'Trims',
          style: txt30,
        ),
        // -----------  Actions start  -----------------

        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) {
              if (item == 0) {
                String yearr = context.read<DataCubit>().getYearFilter;
                print(yearr);
                int h2 = 0;
                Navigator.pushNamed(context, '/YearFilterForm',
                        arguments: yearr)
                    .then((value) {
                  if (value != null) {
                    int g5 = 5;
                    context.read<DataCubit>().setYearFilter(value.toString());

                    TrimCrud.getTrims(
                            '1',
                            context.read<DataCubit>().getYearFilter,
                            context.read<DataCubit>().getMakesIdFilter)
                        .then((val) {
                      context.read<DataCubit>().setTrimReqRes(val);

                      setState(() {
                        _currentPage = 0;
                        _paginatorKey = UniqueKey();
                      });
                    });
                  }
                });
              } else if (item == 1) {
                //  MakesIdFilter
                print('MakesIdFilter');
                Navigator.pushNamed(context, '/MakesIdFilter',
                        arguments: context.read<DataCubit>().getMakesIdFilter)
                    .then((values) {
                  if (values != null && values.toString().trim().isNotEmpty) {
                    if (values != null) {
                      context
                          .read<DataCubit>()
                          .setMakesIdFilter(values.toString());

                      TrimCrud.getTrims(
                              '1',
                              context.read<DataCubit>().getYearFilter,
                              context.read<DataCubit>().getMakesIdFilter)
                          .then((val) {
                        context.read<DataCubit>().setTrimReqRes(val);

                        setState(() {
                          _currentPage = 0;
                          _paginatorKey = UniqueKey();
                        });
                      });
                    }
                  }

                  print(values);
                  int h3 = 3;
                });
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Year'),
                    ],
                  )),
              PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(
                        Icons.car_repair_sharp,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Makes'),
                    ],
                  )),
            ],
          ),
        ],

        // -----------  Actions end  -----------------
      ),
      drawer: DrawerMenu(),
      body: BlocBuilder<DataCubit, Keeper>(builder: (context, state) {
        return Center(
          child: central,
        );
      }),
      bottomNavigationBar: Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        child: NumberPaginator(
          key: _paginatorKey,
          initialPage: _currentPage,
          // by default, the paginator shows numbers as center content
          numberPages: context.read<DataCubit>().getTrimReqRes.pages_total,
          onPageChange: (int index) {
            setState(() {
              _currentPage = index; // Обновление текущей страницы
              TrimCrud.getTrims(
                      (index + 1).toString(),
                      context.read<DataCubit>().getYearFilter,
                      context.read<DataCubit>().getMakesIdFilter)
                  .then(
                (value) {
                  print(value);

                  setState(() {
                    context.read<DataCubit>().setTrimReqRes(value);

                    central = GetCentralWidget(
                        context.read<DataCubit>().getTrimReqRes);
                    _currentPage = 0;
                  });
                },
              );
              print('indes = $index');
            });
          },
        ),
      ),
    );
  }

  //-------------------------  CentralWidget  ----------------------
  Widget GetCentralWidget(ReqRes<Trim> result) {
    Widget central = Text(
      'No Data',
      style: txt15,
    );

    if (result.list.isEmpty) {
      if (result.status == 200) {
        central = Text(
          'No Data',
          style: txt15,
        );
      } else {
        central = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No Data'),
            Text(
              result.message,
              style: txt15,
            ),
          ],
        );
      }
    } else {
      central = ListView.separated(
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
          thickness: 1,
        ),
        itemCount: result.list.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text("${result.list[index].name} "),
            children: [
              ListTile(
                title: Text(
                  'makers: ${result.list[index].make_name}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'model: ${result.list[index].model_name}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'description: ${result.list[index].description}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'year: ${result.list[index].year}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'msrp: ${result.list[index].msrp}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'invoice: ${result.list[index].invoice}',
                  style: txt15,
                ),
              ),
            ],
          );
        },
      );
    }
    return central;
  }
}
