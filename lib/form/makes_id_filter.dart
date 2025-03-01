import 'package:car_api/bloc/block.dart';
import 'package:car_api/constants.dart';
import 'package:car_api/crud/makes_crud.dart';
import 'package:car_api/models/makes.dart';
import 'package:car_api/models/makes_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/src/iterable_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MakesIdFilter extends StatefulWidget {
  MakesIdFilter({super.key, required this.makerId});
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
        backgroundColor: Colors.white,
        title: Text(
          'Select Maker',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<DataCubit, Keeper>(builder: (context, state) {
        Widget central = context
                .read<DataCubit>()
                .getMakesRequestRes
                .message
                .isEmpty
            ? Center(child: CircularProgressIndicator(color: Colors.blue))
            : GetCentralWidget(context.read<DataCubit>().getMakesRequestRes);

        if (context.read<DataCubit>().getMakesRequestRes.status == 0) {
          MakesCrud.getMakes().then((value) {
            context.read<DataCubit>().setMakesRequestRes(value);
            setState(() {});
          });
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: central,
        );
      }),
    );
  }

  Widget GetCentralWidget(MakesRequestRes result) {
    if (result.list.isEmpty) {
      return Center(
        child: Text(
          result.status == 200 ? 'No Data' : result.message,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    } else {
      Makes noneMakes = Makes(0, 'None', '');
      if (result.list.firstWhereOrNull((item) => item.id == noneMakes.id) ==
          null) {
        result.list.insert(0, noneMakes);
      }

      return Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.grey.shade300, thickness: 1),
              itemCount: result.list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: result.list[index].picture.isNotEmpty
                        ? SvgPicture.asset(
                            'assets/icons/${result.list[index].picture}',
                            width: 30,
                          )
                        : Icon(Icons.directions_car, color: Colors.grey),
                  ),
                  title: Text(
                    result.list[index].name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  trailing: Radio<String>(
                    value: result.list[index].id.toString(),
                    groupValue: widget.makerId,
                    onChanged: (val) {
                      setState(() {
                        widget.makerId = val!;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, widget.makerId),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Text('OK', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, null),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  child: Text('Cancel', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          )
        ],
      );
    }
  }
}
