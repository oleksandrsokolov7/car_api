import 'package:car_api/models/trim.dart';

class Engine {
  int id = 0;
  int make_model_trim_id = 0;
  String engine_type = '';
  String fuel_type = '';
  String cylinders = '';
  String size = '';

  int horsepower_hp = 0;
  int horsepower_rpm = 0;
  int torque_ft_lbs = 0;
  int torque_rpm = 0;
  int valves = 0;

  String valve_timing = '';
  String cam_type = '';
  String drive_type = '';
  String transmission = '';

  Trim trim = Trim.empty();

  Engine(
      this.id,
      this.make_model_trim_id,
      this.engine_type,
      this.fuel_type,
      this.cylinders,
      this.size,
      this.horsepower_hp,
      this.horsepower_rpm,
      this.torque_ft_lbs,
      this.torque_rpm,
      this.valves,
      this.valve_timing,
      this.cam_type,
      this.drive_type,
      this.transmission,
      this.trim);

  Engine.empty() {
    id = 0;
    make_model_trim_id = 0;
    engine_type = '';
    fuel_type = '';
    cylinders = '';
    size = '';

    horsepower_hp = 0;
    horsepower_rpm = 0;
    torque_ft_lbs = 0;
    torque_rpm = 0;
    valves = 0;

    valve_timing = '';
    cam_type = '';
    drive_type = '';
    transmission = '';

    trim = Trim.empty();
  }

  Engine.fromJson(Map<String, dynamic> json)
      : id = (json['id'] == null) ? 0 : int.parse(json['id'].toString()),
        make_model_trim_id = (json['make_model_trim_id'] == null)
            ? 0
            : int.parse(json['make_model_trim_id'].toString()),
        engine_type =
            (json['engine_type'] == null) ? '' : json['engine_type'].toString(),
        fuel_type =
            (json['fuel_type'] == null) ? '' : json['fuel_type'].toString(),
        cylinders =
            (json['cylinders'] == null) ? '' : json['cylinders'].toString(),
        size = (json['size'] == null) ? '' : json['size'].toString(),
        horsepower_hp = (json['horsepower_hp'] == null)
            ? 0
            : int.parse(json['horsepower_hp'].toString()),
        horsepower_rpm = (json['horsepower_rpm'] == null)
            ? 0
            : int.parse(json['horsepower_rpm'].toString()),
        torque_ft_lbs = (json['torque_ft_lbs'] == null)
            ? 0
            : int.parse(json['torque_ft_lbs'].toString()),
        torque_rpm = (json['torque_rpm'] == null)
            ? 0
            : int.parse(json['torque_rpm'].toString()),
        valves =
            (json['valves'] == null) ? 0 : int.parse(json['valves'].toString()),
        valve_timing = (json['valve_timing'] == null)
            ? ''
            : json['valve_timing'].toString(),
        cam_type =
            (json['cam_type'] == null) ? '' : json['cam_type'].toString(),
        drive_type =
            (json['drive_type'] == null) ? '' : json['drive_type'].toString(),
        transmission = (json['transmission'] == null)
            ? ''
            : json['transmission'].toString(),
        trim = Trim.fromJson(json['make_model_trim']);

  @override
  String toString() {
    return 'id = $id, make_model_trim_id = $make_model_trim_id, engine_type = $engine_type, fuel_type = $fuel_type, ' ' cylinders = $cylinders, size = $size, horsepower_hp = $horsepower_hp, horsepower_rpm = $horsepower_rpm, ' +
        ' torque_ft_lbs = $torque_ft_lbs, torque_rpm = $torque_rpm, valves = $valves, valve_timing = $valve_timing, ' +
        ' cam_type = $cam_type, drive_type = $drive_type, transmission = $transmission, trim = $trim';
  }
}
