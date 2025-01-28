import 'package:car_api/block.dart';
import 'package:car_api/constants.dart';
import 'package:car_api/crud/makes_crud.dart';
import 'package:car_api/models/makes.dart';
import 'package:car_api/models/makes_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:collection/src/iterable_extensions.dart';

class MakesIdFilter extends StatefulWidget {
  MakesIdFilter({Key? key, required this.makerId}) : super(key: key);
  String makerId = '0';
  @override
  _MakesIdFilterState createState() => _MakesIdFilterState();
}

class _MakesIdFilterState extends State<MakesIdFilter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Maker',
          style: txt30,
        ),
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
      Makes noneMakes = Makes(0, 'None');

      var exist =
          result.list.firstWhereOrNull((item) => item.id == noneMakes.id);

      if (exist == null) {
        result.list.insert(0, noneMakes);
      }

      central = Column(
        children: [
          Flexible(
            flex: 7,
            child: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              itemCount: result.list.length,
              itemBuilder: (context, index) {
                return RadioMenuButton(
                  child: Text(result.list[index].name),
                  value: result.list[index].id.toString(),
                  groupValue: widget.makerId,
                  onChanged: (val) {
                    setState(
                      () {
                        print(val);
                        widget.makerId = val!;
                      },
                    );
                  },
                );
              },
            ),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    child: TextButton(
                        onPressed: () {
                          print(widget.makerId);
                          Navigator.pop(context, widget.makerId);
                        },
                        child: Text('OK')),
                  ),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        print('Cancel');
                        Navigator.pop(context, null);
                      },
                      child: Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    return central;
  }
}
