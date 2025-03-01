import 'package:car_api/constants.dart';
import 'package:car_api/models/model_car.dart';

import 'package:car_api/models/req_res.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ModelCarCrud {
  static Future<ReqRes<ModelCar>> getModelCar(
      String pageNumber, String year, String makeId) async {
    ReqRes<ModelCar> result = ReqRes<ModelCar>.empty();

    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'x-rapidapi-key': r_key,
        'x-rapidapi-host': r_host
      };

      Map<String, String> queryParam = {
        'direction': 'asc',
        'year': year,
        'verbose': 'yes',
        'page': pageNumber
      };

      if (makeId.trim().isNotEmpty && makeId.trim() != '0') {
        queryParam.addAll({'make_id': makeId});
      }

      int h = 0;

      var response = await http.get(
          Uri.https(
            host,
            '/api/models',
            queryParam,
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
        List<ModelCar> list = [];

        for (var map in listModelCar) {
          ModelCar modelCar = ModelCar.fromJson(map);
          list.add(modelCar);
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
