import 'package:car_api/constants.dart';
import 'package:car_api/models/makes.dart';
import 'package:car_api/models/makes_res.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MakesCrud {
  static Future<MakesRequestRes> getMakes() async {
    List<String> icons = [
      'Acura',
      'Alfa Romeo',
      'AM General',
      'Aston Martin',
      'Audi',
      'Bentley',
      'BMW',
      'Bugatti',
      'Buick',
      'Cadillac',
      'Chevrolet',
      'Chrysler',
      'Daewoo',
      'Dodge',
      'Eagle',
      'Ferrari',
      'FIAT',
      'Fisker',
      'Ford',
      'Genesis',
      'Geo',
      'GMC',
      'Honda',
      'HUMMER',
      'Hyundai',
      'INEOS',
      'INFINITI',
      'Isuzu',
      'Jaguar',
      'Jeep',
      'Karma',
      'Kia',
      'Lamborghini',
      'Land Rover',
      'Lexus',
      'Lincoln',
      'Lotus',
      'Lucid',
      'Maserati',
      'Maybach',
      'Mazda',
      'McLaren',
      'Mercedes-Benz',
      'Mercury',
      'MINI',
      'Mitsubishi',
      'Nissan',
      'Oldsmobile',
      'Panoz',
      'Plymouth',
      'Polestar',
      'Pontiac',
      'Porsche',
      'Ram',
      'Rivian',
      'Rolls-Royce',
      'Saab',
      'Saturn',
      'Scion',
      'smart',
      'Spyker',
      'Subaru',
      'Suzuki',
      'Tesla',
      'Toyota',
      'VinFast',
      'Volkswagen',
      'Volvo'
    ];

    MakesRequestRes result = MakesRequestRes.empty();

    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'x-rapidapi-key': r_key,
        'x-rapidapi-host': r_host
      };

      var response = await http.get(
          Uri.https(host, '/api/makes', {'direction': 'asc', 'sort': 'name'}),
          headers: headers);

      result.status = response.statusCode;

      int h = 0;

      if (response.statusCode == 200) {
        dynamic body = (json.decode(response.body) as dynamic);
        print(body);

        List<dynamic> listMakes = body['data'] as List<dynamic>;
        int h2 = 0;
        List<Makes> list = [];

        for (var map in listMakes) {
          Makes makes = Makes.fromJson(map);

          if (icons.contains(makes.name)) {
            makes.picture = '${makes.name}.svg';
          }

          list.add(makes);
        }

        result.list = list;
        result.message = 'OK';

        if (result.list.isEmpty) {
          result.message = 'No Data';
        }

        return result;
      } else {
        print(response.statusCode);
        result.message = 'statusCode ${response.statusCode}';
        return result;
      }
    } on Exception catch (exception) {
      print('exception: $exception');
      result.message = 'exception: $exception';
      return result;
    } catch (error) {
      print('error: $error');
      result.message = 'error: $error';
      return result;
    }
  }
}
