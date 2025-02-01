import 'package:car_api/models/trim.dart';

class Body {
  int id = 0;
  int make_model_trim_id = 0;
  String type = '';

  int doors = 0;
  String length = '';
  String width = '';
  int seats = 0;
  String height = '';
  String wheel_base = '';

  String front_track = '';
  String rear_track = '';
  String ground_clearance = '';

  String cargo_capacity = '';
  String max_cargo_capacity = '';

  int curb_weight = 0;
  int gross_weight = 0;
  int max_payload = 0;
  int max_towing_capacity = 0;

  Trim trim = Trim.empty();

  Body(
      this.id,
      this.make_model_trim_id,
      this.type,
      this.doors,
      this.length,
      this.width,
      this.seats,
      this.height,
      this.wheel_base,
      this.front_track,
      this.rear_track,
      this.ground_clearance,
      this.cargo_capacity,
      this.max_cargo_capacity,
      this.curb_weight,
      this.gross_weight,
      this.max_payload,
      this.max_towing_capacity,
      this.trim);

  Body.empty() {
    id = 0;
    make_model_trim_id = 0;
    type = '';

    doors = 0;
    length = '';
    width = '';
    seats = 0;
    height = '';
    wheel_base = '';

    front_track = '';
    rear_track = '';
    ground_clearance = '';

    cargo_capacity = '';
    max_cargo_capacity = '';
    curb_weight = 0;

    gross_weight = 0;
    max_payload = 0;
    max_towing_capacity = 0;
    trim = Trim.empty();
  }

  Body.fromJson(Map<String, dynamic> json)
      : id = (json['id'] == null) ? 0 : int.parse(json['id'].toString()),
        make_model_trim_id = (json['make_model_trim_id'] == null)
            ? 0
            : int.parse(json['make_model_trim_id'].toString()),
        type = (json['type'] == null) ? '' : json['type'].toString(),
        doors =
            (json['doors'] == null) ? 0 : int.parse(json['doors'].toString()),
        length = (json['length'] == null) ? '' : json['length'].toString(),
        width = (json['width'] == null) ? '' : json['width'].toString(),
        seats =
            (json['seats'] == null) ? 0 : int.parse(json['seats'].toString()),
        height = (json['height'] == null) ? '' : json['height'].toString(),
        wheel_base =
            (json['wheel_base'] == null) ? '' : json['wheel_base'].toString(),
        cargo_capacity = (json['cargo_capacity'] == null)
            ? ''
            : json['cargo_capacity'].toString(),
        max_cargo_capacity = (json['max_cargo_capacity'] == null)
            ? ''
            : json['max_cargo_capacity'].toString(),
        curb_weight = (json['curb_weight'] == null)
            ? 0
            : int.parse(json['curb_weight'].toString()),
        gross_weight = (json['gross_weight'] == null)
            ? 0
            : int.parse(json['gross_weight'].toString()),
        max_payload = (json['max_payload'] == null)
            ? 0
            : int.parse(json['max_payload'].toString()),
        max_towing_capacity = (json['max_towing_capacity'] == null)
            ? 0
            : int.parse(json['max_towing_capacity'].toString()),
        trim = Trim.fromJson(json['make_model_trim']);

  @override
  String toString() {
    return 'id = $id, make_model_trim_id = $make_model_trim_id, type = $type, doors = $doors, ' +
        ' length = $length, width = $width, seats = $seats, height = $height, wheel_base = $wheel_base, ' +
        ' front_track = $front_track, rear_track = $rear_track, ground_clearance = $ground_clearance, ' +
        ' cargo_capacity = $cargo_capacity, max_cargo_capacity = $max_cargo_capacity, curb_weight = $curb_weight ' +
        ' gross_weight = $gross_weight, max_payload = $max_payload, max_towing_capacity = $max_towing_capacity, trim = $trim ';
  }
}
