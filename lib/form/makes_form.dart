import 'package:car_api/bloc/block.dart';
import 'package:car_api/bloc/theme_bloc.dart';
import 'package:car_api/constants.dart';
import 'package:car_api/crud/makes_crud.dart';
import 'package:car_api/models/makes_res.dart';
import 'package:car_api/widget/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_api/models/makes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MakesForm extends StatefulWidget {
  const MakesForm({super.key});

  @override
  _MakesFormState createState() => _MakesFormState();
}

class _MakesFormState extends State<MakesForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.menu_rounded),
          ),
        ),
        backgroundColor: Colors.blue,
        title: Text(
          'Makes Form',
          style: txt30,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DataCubit, Keeper>(
        builder: (context, state) {
          if (context.read<DataCubit>().getMakesRequestRes.status == 0) {
            MakesCrud.getMakes().then((value) {
              context.read<DataCubit>().setMakesRequestRes(value);
              setState(() {});
            });
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          }

          return GetCentralWidget(context.read<DataCubit>().getMakesRequestRes);
        },
      ),
      drawer: DrawerMenu(),
    );
  }

  Widget GetCentralWidget(MakesRequestRes result) {
    if (result.list.isEmpty) {
      return Center(
        child: Text(
          result.status == 200 ? 'No Data' : result.message,
          style: txt15,
        ),
      );
    }

    result.list.removeWhere((item) => item.id == 0);

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
                            ? Colors.grey[800] // темный фон для темной темы
                            : Theme.of(context)
                                .hoverColor, // стандартный фон для светлой темы
                    child: result.list[index].picture.isNotEmpty
                        ? Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white.withOpacity(
                                      0.6) // светлый фон для темной темы
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
                              'assets/icons/${result.list[index].picture}',
                              width: 50,
                              height: 50,
                            ),
                          )
                        : Icon(Icons.directions_car,
                            size: 50,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black),
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
