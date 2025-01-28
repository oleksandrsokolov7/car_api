import 'package:car_api/constants.dart';
import 'package:car_api/models/makes.dart';
import 'package:car_api/models/makes_res.dart';
import 'package:car_api/models/req_res.dart';
import 'package:car_api/models/trim.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class TrimCrud {
  static Future<ReqRes<Trim>> getTrims(
      String page_number, String year, String make_id) async {
    ReqRes<Trim> result = ReqRes<Trim>.empty();

    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'x-rapidapi-key': r_key,
        'x-rapidapi-host': r_host
      };

      Map<String, String> query_param = {
        'direction': 'asc',
        'year': year,
        'verbose': 'yes',
        'page': page_number
      };

      if (make_id.trim().isNotEmpty && make_id.trim() != '0') {
        query_param.addAll({'make_id': make_id});
      }

      var response = await http.get(
          Uri.https(
            host,
            '/api/trims',
            query_param,
          ),
          headers: headers);

      result.status = response.statusCode;

      if (response.statusCode == 200) {
        dynamic body = (json.decode(response.body) as dynamic);

        var count = body['collection']['count'] as int;
        var total = body['collection']['total'] as int;
        var pages = body['collection']['pages'] as int;

        result.pages_total = pages;
        result.total_item = total;
        result.page_size = count;

        print(body);

        List<dynamic> listModelCar = body['data'] as List<dynamic>;
        int h2 = 0;
        List<Trim> list = [];

        listModelCar.forEach((dynamic map) {
          Trim modelCar = Trim.fromJson(map);
          list.add(modelCar);
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
