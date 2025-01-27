import 'package:car_api/constants.dart';
import 'package:car_api/models/makes.dart';
import 'package:car_api/models/makes_res.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MakesCrud {
  static Future<MakesRequestRes> getMakes() async {
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

        listMakes.forEach((dynamic map) {
          Makes makes = Makes.fromJson(map);
          list.add(makes);
        });

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
