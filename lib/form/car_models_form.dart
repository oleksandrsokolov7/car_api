import 'package:car_api/bloc/block.dart';
import 'package:car_api/constants.dart';
import 'package:car_api/crud/model_car_crud.dart';
import 'package:car_api/models/model_car.dart';
import 'package:car_api/models/req_res.dart';
import 'package:car_api/widget/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:number_paginator/number_paginator.dart';

class CarModelsForm extends StatefulWidget {
  const CarModelsForm({Key? key}) : super(key: key);

  @override
  _CarModelsFormState createState() => _CarModelsFormState();
}

class _CarModelsFormState extends State<CarModelsForm> {
  int _currentPage = 0; // Variable for storing current page
  UniqueKey _paginatorKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    Widget central =
        context.read<DataCubit>().getModelCarRequestRes.message.isEmpty
            ? CircularProgressIndicator(
                color: Colors.blue,
              )
            : Center(
                child: GetCentralWidget(
                    context.read<DataCubit>().getModelCarRequestRes),
              );

    if (context.read<DataCubit>().getModelCarRequestRes.status == 0) {
      ModelCarCrud.getModelCar('1', context.read<DataCubit>().getYearFilter,
              context.read<DataCubit>().getMakesIdFilter)
          .then(
        (value) {
          context.read<DataCubit>().setModelCarRequestRes(value);
          central =
              GetCentralWidget(context.read<DataCubit>().getModelCarRequestRes);
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
          'Car Models',
          style: txt30,
        ),
        actions: <Widget>[
          PopupMenuButton<int>(
            onSelected: (item) {
              if (item == 0) {
                Navigator.pushNamed(context, '/YearFilterForm',
                        arguments: context.read<DataCubit>().getYearFilter)
                    .then((value) {
                  if (value != null) {
                    context.read<DataCubit>().setYearFilter(value.toString());
                    _refreshModels();
                  }
                });
              } else if (item == 1) {
                Navigator.pushNamed(context, '/MakesIdFilter',
                        arguments: context.read<DataCubit>().getMakesIdFilter)
                    .then((values) {
                  if (values != null) {
                    context
                        .read<DataCubit>()
                        .setMakesIdFilter(values.toString());
                    _refreshModels();
                  }
                });
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 0,
                  child: Row(
                    children: [
                      Icon(Icons.calendar_month, color: Colors.black),
                      SizedBox(width: 5),
                      Text('Year'),
                    ],
                  )),
              PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      Icon(Icons.car_repair_sharp, color: Colors.black),
                      SizedBox(width: 5),
                      Text('Makes'),
                    ],
                  )),
            ],
          ),
        ],
      ),
      drawer: DrawerMenu(),
      body: BlocBuilder<DataCubit, Keeper>(
        builder: (context, state) {
          return Center(child: central);
        },
      ),
      bottomNavigationBar: Card(
        margin: EdgeInsets.zero,
        elevation: 4,
        child: NumberPaginator(
          key: _paginatorKey,
          initialPage: _currentPage,
          numberPages:
              context.read<DataCubit>().getModelCarRequestRes.pages_total,
          onPageChange: (int index) {
            setState(() {
              _currentPage = index;
              _refreshModels();
            });
          },
        ),
      ),
    );
  }

  void _refreshModels() {
    ModelCarCrud.getModelCar(
      (this._currentPage + 1).toString(),
      context.read<DataCubit>().getYearFilter,
      context.read<DataCubit>().getMakesIdFilter,
    ).then((value) {
      context.read<DataCubit>().setModelCarRequestRes(value);
      setState(() {});
    });
  }

  Widget GetCentralWidget(ReqRes<ModelCar> result) {
    if (result.list.isEmpty) {
      return Center(
        child: Text(
          result.status == 200 ? 'No Data' : result.message,
          style: txt15,
        ),
      );
    }

    result.list.removeWhere((item) => item.id == 0);
    // Remove duplicates based on ID
    result.list = result.list.toSet().toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: result.list.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[800]
                            : Theme.of(context).hoverColor,
                    child: result.list[index].id.isEven
                        ? Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white.withOpacity(0.6)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.black45
                                      : Colors.transparent,
                                  blurRadius: 6.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/${result.list[index].id}',
                              width: 50,
                              height: 50,
                            ),
                          )
                        : Icon(
                            Icons.directions_car,
                            size: 50,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    result.list[index].name,
                    style: txt20,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
