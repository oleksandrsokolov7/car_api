import 'package:car_api/bloc/block.dart';
import 'package:car_api/constants.dart';
import 'package:car_api/crud/vin_model_crud.dart';
import 'package:car_api/models/req_res.dart';
import 'package:car_api/models/vin_model.dart';
import 'package:car_api/widget/alert_dialog.dart';
import 'package:car_api/widget/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VinModelForm extends StatefulWidget {
  const VinModelForm({Key? key}) : super(key: key);

  @override
  _VinModelFormState createState() => _VinModelFormState();
}

class _VinModelFormState extends State<VinModelForm> {
  // String vin = '1GTG6CEN0L1139305';
  Widget central = Image.asset(
    "assets/images/CarApi1.png",
    width: 200,
    height: 200,
  );
  TextEditingController vinController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
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
        //  backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'VIN',
          style: txt30,
        ),
      ),
      drawer: DrawerMenu(),
      body: BlocBuilder<DataCubit, Keeper>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: vinController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'VIN',
                        hintText: 'Enter vin as 1GTG6CEN0L1139305'),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 200,
                        child: ElevatedButton(
                          //  style: ButtonStyle(backgroundColor: )
                          onPressed: () {
                            if (vinController.text.trim().isEmpty) {
                              showMyDialog(
                                  context, 'The vin number field is empty!');
                            } else {
                              ReqRes<VinModel> vinModel =
                                  ReqRes<VinModel>.empty();
                              context
                                  .read<DataCubit>()
                                  .setVinModelReqRes(vinModel);

                              setState(
                                () {
                                  central = CircularProgressIndicator(
                                    color: Colors.blue,
                                  );
                                },
                              );

                              VinModelCrud.getVinModeles(vinController.text)
                                  .then(
                                (value) {
                                  print(value);
                                  context
                                      .read<DataCubit>()
                                      .setVinModelReqRes(value);

                                  setState(
                                    () {
                                      central = GetCentralWidget(context
                                          .read<DataCubit>()
                                          .getVinModelReqRes);
                                    },
                                  );
                                },
                              );
                            }
                          },
                          child: Text(
                            'GO',
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            String vin = VinModelCrud.getRandomVin();
                            vinController.text = vin;
                            print(vin);
                          },
                          child: Text(
                            'RND',
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              Flexible(
                flex: 10,
                child: Center(
                  child: central,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  //-------------------------  CentralWidget  ----------------------
  Widget GetCentralWidget(ReqRes<VinModel> result) {
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
      central = ListView(
        children: [
          //=======================================
          ListTile(
            title: Text(
              'model: ${result.list[0].model}',
              style: txt20,
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          ListTile(
            title: Text(
              'make: ${result.list[0].make}',
              style: txt20,
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          ListTile(
            title: Text(
              'trim: ${result.list[0].trim}',
              style: txt20,
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 1,
          ),
          ListTile(
            title: Text(
              'year: ${result.list[0].year}',
              style: txt20,
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          ExpansionTile(
            title: Text('SPECS: '),
            children: [
              ListTile(
                title: Text(
                  'body_class: ${result.list[0].body_class}',
                  style: txt20,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text(
                  'cab_type: ${result.list[0].cab_type}',
                  style: txt20,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text(
                  'displacement_cc: ${result.list[0].displacement_cc}',
                  style: txt20,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text(
                  'displacement_ci: ${result.list[0].displacement_ci}',
                  style: txt20,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text(
                  'displacement_l: ${result.list[0].displacement_l}',
                  style: txt20,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text(
                  'doors: ${result.list[0].doors}',
                  style: txt20,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text(
                  'drive type: ${result.list[0].drive_type}',
                  style: txt20,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text(
                  'engine configuration: ${result.list[0].engine_configuration}',
                  style: txt20,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text(
                  'engine model: ${result.list[0].engine_model}',
                  style: txt20,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text(
                  'engine number of cylinders: ${result.list[0].engine_number_of_cylinders}',
                  style: txt20,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text(
                  'number of seat rows: ${result.list[0].number_of_seat_rows}',
                  style: txt20,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              ListTile(
                title: Text(
                  'number of seats: ${result.list[0].number_of_seats}',
                  style: txt20,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
            thickness: 2,
          ),
          //=======================================
          ExpansionTile(
            title: Text('Trims: '),
            //  subtitle:
            children: [
              SizedBox(
                height: 400,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  itemCount: result.list[0].trims.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: Text("${result.list[0].trims[index].name} "),
                      children: [
                        ListTile(
                          title: Text(
                            'makers: ${result.list[0].trims[index].make_name}',
                            style: txt15,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'model: ${result.list[0].trims[index].model_name}',
                            style: txt15,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'description: ${result.list[0].trims[index].description}',
                            style: txt15,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'year: ${result.list[0].trims[index].year}',
                            style: txt15,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'msrp: ${result.list[0].trims[index].msrp}',
                            style: txt15,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'invoice: ${result.list[0].trims[index].invoice}',
                            style: txt15,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      );
    }
    return central;
  }
}
