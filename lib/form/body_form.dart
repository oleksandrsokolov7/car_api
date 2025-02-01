import 'package:car_api/constants.dart';
import 'package:car_api/crud/body_crud.dart';
import 'package:car_api/models/body.dart';
import 'package:car_api/models/engine.dart';
import 'package:car_api/models/req_res.dart';
import 'package:car_api/widget/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:car_api/block.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';

class BodyForm extends StatefulWidget {
  const BodyForm({Key? key}) : super(key: key);

  @override
  _BodyFormState createState() => _BodyFormState();
}

class _BodyFormState extends State<BodyForm> {
  int _currentPage = 0; // Переменная для хранения текущей страницы
  UniqueKey _paginatorKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    Widget central = context.read<DataCubit>().getBodyReqRes.message.isEmpty
        ? CircularProgressIndicator(
            color: Colors.blue,
          )
        : Center(
            child: GetCentralWidget(context.read<DataCubit>().getBodyReqRes),
          );

    if (context.read<DataCubit>().getBodyReqRes.status == 0) {
      BodyCrud.getBodyes('1', '2020', '0').then(
        (value) {
          print(value);
          context.read<DataCubit>().setBodyReqRes(value);

          central = GetCentralWidget(context.read<DataCubit>().getBodyReqRes);

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
          'Body',
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

                    BodyCrud.getBodyes(
                            '1',
                            context.read<DataCubit>().getYearFilter,
                            context.read<DataCubit>().getMakesIdFilter)
                        .then((val) {
                      context.read<DataCubit>().setBodyReqRes(val);

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

                      BodyCrud.getBodyes(
                              '1',
                              context.read<DataCubit>().getYearFilter,
                              context.read<DataCubit>().getMakesIdFilter)
                          .then((val) {
                        context.read<DataCubit>().setBodyReqRes(val);

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
          numberPages: context.read<DataCubit>().getBodyReqRes.pages_total,
          onPageChange: (int index) {
            setState(() {
              _currentPage = index; // Обновление текущей страницы
              BodyCrud.getBodyes(
                      (index + 1).toString(),
                      context.read<DataCubit>().getYearFilter,
                      context.read<DataCubit>().getMakesIdFilter)
                  .then(
                (value) {
                  print(value);

                  setState(() {
                    context.read<DataCubit>().setBodyReqRes(value);

                    central = GetCentralWidget(
                        context.read<DataCubit>().getBodyReqRes);
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
  Widget GetCentralWidget(ReqRes<Body> result) {
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
            title: Text(
                "${result.list[index].trim.make_name}  ${result.list[index].trim.model_name} "),
            children: [
              ListTile(
                title: Text(
                  'type: ${result.list[index].type}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'doors: ${result.list[index].doors}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'length: ${result.list[index].length}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'seats: ${result.list[index].seats}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'height: ${result.list[index].height}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'wheel_base: ${result.list[index].wheel_base}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'front_track: ${result.list[index].front_track}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'rear_track: ${result.list[index].rear_track}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'ground_clearance: ${result.list[index].ground_clearance}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'cargo_capacity: ${result.list[index].cargo_capacity}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'max_cargo_capacity: ${result.list[index].max_cargo_capacity}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'curb_weight: ${result.list[index].curb_weight}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'gross_weight: ${result.list[index].gross_weight}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'max_payload: ${result.list[index].max_payload}',
                  style: txt15,
                ),
              ),
              ListTile(
                title: Text(
                  'max_towing_capacity: ${result.list[index].max_towing_capacity}',
                  style: txt15,
                ),
              ),
              ExpansionTile(
                title: Text('Trim: ${result.list[index].trim.name}'),
                subtitle: Text(
                    "${result.list[index].trim.make_name}  ${result.list[index].trim.model_name} "),
                children: [
                  ListTile(
                    title: Text(
                      'year: ${result.list[index].trim.year}',
                      style: txt15,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'description: ${result.list[index].trim.description}',
                      style: txt15,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'msrp: ${result.list[index].trim.msrp}',
                      style: txt15,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'invoice: ${result.list[index].trim.invoice}',
                      style: txt15,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    }
    return central;
  }
}
