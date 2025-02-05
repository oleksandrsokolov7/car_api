import 'package:car_api/bloc/block.dart';
import 'package:car_api/constants.dart';
import 'package:car_api/crud/makes_crud.dart';
import 'package:car_api/models/makes_res.dart';
import 'package:car_api/widget/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakesForm extends StatefulWidget {
  const MakesForm({Key? key}) : super(key: key);

  @override
  _MakesFormState createState() => _MakesFormState();
}

class _MakesFormState extends State<MakesForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                print('on_press');
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu_rounded),
            );
          },
        ),
        backgroundColor: Colors.blue,
        title: Text(
          'Makes Form',
          style: txt30,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DataCubit, Keeper>(builder: (context, state) {
        Widget central =
            context.read<DataCubit>().getMakesRequestRes.message.isEmpty
                ? CircularProgressIndicator(
                    color: Colors.blue,
                  )
                : Center(
                    child: GetCentralWidget(
                        context.read<DataCubit>().getMakesRequestRes),
                  );

        if (context.read<DataCubit>().getMakesRequestRes.status == 0) {
          MakesCrud.getMakes().then(
            (value) {
              print(value);
              context.read<DataCubit>().setMakesRequestRes(value);

              central = GetCentralWidget(
                  context.read<DataCubit>().getMakesRequestRes);

              setState(() {});
            },
          );
        }

        return Center(
          child: central,
        );
      }),
      drawer: DrawerMenu(),
    );
  }

  Widget GetCentralWidget(MakesRequestRes result) {
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
          return ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue,
                child: Text(
                  '${result.list[index].id}',
                  style: txt15,
                ),
              ),
            ),
            // leading: Text(
            //   '${result.list[index].id}',
            //   style: txt20,
            // ),

            contentPadding: EdgeInsets.zero,
            dense: true,
            title: Text(
              '${result.list[index].name}',
              style: txt20,
            ),
          );
        },
      );
    }
    return central;
  }
}
