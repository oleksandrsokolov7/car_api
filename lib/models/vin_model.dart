import 'package:car_api/models/trim.dart';

class VinModel {
  int year = 0;
  String make = '';
  String model = '';
  String trim = '';
  //------------------------------------
  String body_class = '';
  String cab_type = '';
  String displacement_cc = '';
//
  String displacement_ci = '';
  String displacement_l = '';
  String doors = '';
//
  String drive_type = '';
  String engine_configuration = '';
  String engine_model = '';
//
  String engine_number_of_cylinders = '';
  String number_of_seat_rows = '';
  String number_of_seats = '';
  //
  String number_of_wheels = '';
  String vehicle_descriptor = '';
  String vehicle_type = '';
//   //------------------------------------
  List<Trim> trims = [];

  VinModel(
      this.year,
      this.make,
      this.model,
      this.trim,
      //------------------------------------
      this.body_class,
      this.cab_type,
      this.displacement_cc,
//
      this.displacement_ci,
      this.displacement_l,
      this.doors,
//
      this.drive_type,
      this.engine_configuration,
      this.engine_model,
//
      this.engine_number_of_cylinders,
      this.number_of_seat_rows,
      this.number_of_seats,
      //
      this.number_of_wheels,
      this.vehicle_descriptor,
      this.vehicle_type,
      this.trims);

  VinModel.empty() {
    year = 0;
    make = '';
    model = '';
    trim = '';
    //------------------------------------
    body_class = '';
    cab_type = '';
    displacement_cc = '';
//
    displacement_ci = '';
    displacement_l = '';
    doors = '';
//
    drive_type = '';
    engine_configuration = '';
    engine_model = '';
//
    engine_number_of_cylinders = '';
    number_of_seat_rows = '';
    number_of_seats = '';
    //
    number_of_wheels = '';
    vehicle_descriptor = '';
    vehicle_type = '';
    //------------------------------------
    trims = [];
  }

  VinModel.fromJson(Map<String, dynamic> json)
      : year = (json['year'] == null) ? 0 : int.parse(json['year'].toString()),
        make = (json['make'] == null) ? '' : json['make'].toString(),
        model = (json['model'] == null) ? '' : json['model'].toString(),
        trim = (json['specs']['trim'] == null)
            ? ''
            : json['specs']['trim'].toString(),
        body_class = (json['specs']['body_class'] == null)
            ? ''
            : json['specs']['body_class'].toString(),
        cab_type = (json['specs']['cab_type'] == null)
            ? ''
            : json['specs']['cab_type'].toString(),
        //
        displacement_cc = (json['specs']['displacement_cc'] == null)
            ? ''
            : json['specs']['displacement_cc'].toString(),
        //
        displacement_ci = (json['specs']['displacement_ci'] == null)
            ? ''
            : json['specs']['displacement_ci'].toString(),
        //
        displacement_l = (json['specs']['displacement_l'] == null)
            ? ''
            : json['specs']['displacement_l'].toString(),
        //
        doors = (json['specs']['doors'] == null)
            ? ''
            : json['specs']['doors'].toString(),
        //
        drive_type = (json['specs']['drive_type'] == null)
            ? ''
            : json['specs']['drive_type'].toString(),
        //
        engine_configuration = (json['specs']['engine_configuration'] == null)
            ? ''
            : json['specs']['engine_configuration'].toString(),
        //
        engine_model = (json['specs']['engine_model'] == null)
            ? ''
            : json['specs']['engine_model'].toString(),
        engine_number_of_cylinders =
            (json['specs']['engine_number_of_cylinders'] == null)
                ? ''
                : json['specs']['engine_number_of_cylinders'].toString(),
//
        number_of_seat_rows = (json['specs']['number_of_seat_rows'] == null)
            ? ''
            : json['specs']['number_of_seat_rows'].toString(),
        //
        number_of_seats = (json['specs']['number_of_seats'] == null)
            ? ''
            : json['specs']['number_of_seats'].toString(),
        number_of_wheels = (json['specs']['number_of_wheels'] == null)
            ? ''
            : json['specs']['number_of_wheels'].toString(),
        vehicle_descriptor = (json['specs']['vehicle_descriptor'] == null)
            ? ''
            : json['specs']['vehicle_descriptor'].toString(),
        vehicle_type = (json['specs']['vehicle_type'] == null)
            ? ''
            : json['specs']['vehicle_type'].toString(),
        trims = Trim.fromListJson(json['trims'] as List<dynamic>);

  @override
  String toString() {
    return 'year = $year, make = $make, model = $model, trim = $trim, ' ' body_class = $body_class, cab_type = $cab_type, displacement_cc = $displacement_cc, ' +
        ' displacement_ci = $displacement_ci, displacement_l = $displacement_l, doors = $doors, ' +
        ' drive_type = $drive_type, engine_configuration = $engine_configuration, engine_model = $engine_model, ' +
        ' engine_number_of_cylinders = $engine_number_of_cylinders, number_of_seat_rows = $number_of_seat_rows, number_of_seats = $number_of_seats,  ' +
        ' number_of_wheels = $number_of_wheels, vehicle_descriptor = $vehicle_descriptor, vehicle_type = $vehicle_type, trims = $trims';
  }
}
