import 'package:car_api/bloc/block.dart';
import 'package:car_api/constants.dart';
import 'package:car_api/crud/vin_model_crud.dart';
import 'package:car_api/models/req_res.dart';
import 'package:car_api/models/vin_model.dart';
import 'package:car_api/widget/alert_dialog.dart';
import 'package:car_api/widget/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VinModelForm extends StatefulWidget {
  const VinModelForm({super.key});

  @override
  _VinModelFormState createState() => _VinModelFormState();
}

class _VinModelFormState extends State<VinModelForm> {
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
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: Icon(Icons.menu_rounded, color: Colors.white),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text(
          'VIN Lookup',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      drawer: DrawerMenu(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocBuilder<DataCubit, Keeper>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      controller: vinController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Enter VIN',
                        hintText: 'e.g., 1GTG6CEN0L1139305',
                        prefixIcon: Icon(Icons.directions_car),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () {
                          if (vinController.text.trim().isEmpty) {
                            showMyDialog(context, 'The VIN field is empty!');
                          } else {
                            ReqRes<VinModel> vinModel =
                                ReqRes<VinModel>.empty();
                            context
                                .read<DataCubit>()
                                .setVinModelReqRes(vinModel);

                            setState(() {
                              central = CircularProgressIndicator(
                                  color: Colors.blueAccent);
                            });

                            VinModelCrud.getVinModeles(vinController.text)
                                .then((value) {
                              context
                                  .read<DataCubit>()
                                  .setVinModelReqRes(value);
                              setState(() {
                                central = GetCentralWidget(context
                                    .read<DataCubit>()
                                    .getVinModelReqRes);
                              });
                            });
                          }
                        },
                        child: Text('SEARCH',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Colors.grey.shade300,
                        ),
                        onPressed: () {
                          String vin = VinModelCrud.getRandomVin();
                          vinController.text = vin;
                        },
                        child: Text('RANDOM',
                            style:
                                TextStyle(fontSize: 18, color: Colors.black)),
                      ),
                    ],
                  ),
                ),
                Flexible(child: Divider(color: Colors.grey, thickness: 1)),
                Flexible(flex: 10, child: Center(child: central)),
              ],
            );
          },
        ),
      ),
    );
  }

  //-------------------------  CentralWidget  ----------------------
  Widget GetCentralWidget(ReqRes<VinModel> result) {
    if (result.list.isEmpty) {
      return Center(
        child: Text(
          result.status == 200 ? 'No Data' : result.message,
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      );
    } else {
      return ListView(
        padding: EdgeInsets.all(12),
        children: [
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/icons/${result.list[0].make.toLowerCase()}.svg',
                width: 40,
              ),
              title: Text('Model: ${result.list[0].model}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text(
                  'Year: ${result.list[0].year} • Trim: ${result.list[0].trim}'),
            ),
          ),
          SizedBox(height: 10),
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              title: Text('Vehicle Specifications',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              children: [
                _buildSpecTile('Body Class', result.list[0].body_class),
                _buildSpecTile('Engine Model', result.list[0].engine_model),
                _buildSpecTile('Cylinders',
                    result.list[0].engine_number_of_cylinders.toString()),
                _buildSpecTile('Doors', result.list[0].doors.toString()),
                _buildSpecTile('Drive Type', result.list[0].drive_type),
              ],
            ),
          ),
          SizedBox(height: 10),
          Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              title: Text('Available Trims',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              children: result.list[0].trims
                  .map((trim) => ListTile(
                        title: Text('${trim.name} (${trim.year})'),
                        subtitle: Text(
                            'MSRP: \$${trim.msrp} | Invoice: \$${trim.invoice}'),
                      ))
                  .toList(),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildSpecTile(String title, String value) {
    return ListTile(
      leading: Icon(Icons.check_circle_outline, color: Colors.blueAccent),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      trailing: Text(value, style: TextStyle(color: Colors.black87)),
    );
  }
}
