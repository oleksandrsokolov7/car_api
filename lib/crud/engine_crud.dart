import 'package:car_api/constants.dart';
import 'package:car_api/models/engine.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:car_api/models/req_res.dart';

class EngineCrud {
  static Future<ReqRes<Engine>> getEngines(
      String pageNumber, String year, String makeId) async {
    ReqRes<Engine> result = ReqRes<Engine>.empty();

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

      var response = await http.get(
          Uri.https(
            host,
            '/api/engines',
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

        List<dynamic> listEngine = body['data'] as List<dynamic>;
        int h2 = 0;
        List<Engine> list = [];

        for (var map in listEngine) {
          try {
            Engine engine = Engine.fromJson(map);
            list.add(engine);
          } catch (e) {
            print(e);
          }
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
