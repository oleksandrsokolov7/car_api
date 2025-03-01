import 'package:car_api/constants.dart';
import 'package:car_api/models/vin_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:car_api/models/req_res.dart';
import 'dart:math';

class VinModelCrud {
  static Future<ReqRes<VinModel>> getVinModeles(String vin) async {
    ReqRes<VinModel> result = ReqRes<VinModel>.empty();

    try {
      var headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'x-rapidapi-key': r_key,
        'x-rapidapi-host': r_host
      };

      var response =
          await http.get(Uri.https(host, '/api/vin/$vin'), headers: headers);

      result.status = response.statusCode;

      if (response.statusCode == 200) {
        // dynamic body = (json.decode(response.body) as dynamic);

        // print(body);

        // dynamic vin_model = body as dynamic;
        int h2 = 0;

        try {
          VinModel model = VinModel.fromJson(json.decode(response.body));
          result = ReqRes<VinModel>.single(model, 'OK', response.statusCode);
        } catch (e) {
          print(e);
        }

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
//   Set<String> uniqueNames = {'Alice', 'Bob', 'Alice', 'Charlie'};

  static String getRandomVin() {
    Set<String> vinList = {
      '1HGCM82633A123456', // (Honda, 2016)
      '2T1BU4EE5CC123456', // (Toyota, 2016)
      '3VWCM7AJ7HM123456', //(Volkswagen, 2017)
      '5YJ3E1EB2HF123456', //(Tesla, 2017)
      'JM1GJ1W56G1234567', //(Mazda, 2016)
      'WAUZZZ8V0HA123456', //(Audi, 2017)
      'WBA8E9C57JG123456', //(BMW, 2018)
      '1FADP3F25EL123456', //(Ford, 2018)
      'JN1AZ4EH8FM123456', //(Nissan, 2018)
      'KL4CJASB3GB123456', //(Chevrolet, 2016)
      '1C4RJFBG5GC123456', //(Jeep, 2016)
      '5FNRL6H75KB123456', //(Honda, 2019)
      '3C6JR7AG5HG123456', //(Ram, 2017)
      '1G1JC5SB7G4123456', //(Chevrolet, 2016)
      '2HGFB2F56GH123456', //(Honda, 2016)
      '1G1BE5SM7H7123456', //(Chevrolet, 2017)
      '1FM5K8D84GGA12345', //(Ford, 2016)
      '1N4AL3AP5GC123456', //(Nissan, 2016)
      '1C4RJFAG5FC123456', //(Jeep, 2015)
      '5YJSA1E21HF123456', //(Tesla, 2015)
      '1HGCR2F3XFA123456', //(Honda, 2015)
      '1FM5K7B83GGA12345', //(Ford, 2016)
      '1HGCM82633A123457', //(Honda, 2016)
      'WVWZZZ1JZXW123456', // (Volkswagen, 2016, Германия)
      '3FA6P0HD2JR123456', // (Ford, 2018, Мексика)
      'JN1CV6AP0LM123456', // (Nissan, 2020, Япония)
      '5YJSA1E26JF123456', // (Tesla, 2018, США)
      '2G1WF52E459123456', // (Chevrolet, 2015, Канада)
      'WAUZZZ4G4HN123456', // (Audi, 2017, Германия)
      'ZAM57XSA9L1234567', // (Maserati, 2020, Италия)
      'VF1RFA00756912345', // (Renault, 2016, Франция)
      'JH4KA2660MC123456', // (Acura, 2021, Япония)
      'YV1MW382162123456', // (Volvo, 2015, Швеция)
      'KMHCU4AE6JU123456', // (Hyundai, 2018, Южная Корея)
      '1C4RJEBG8LC123456', // (Jeep, 2020, США)
      'WBA3B9C59DF123456', // (BMW, 2019, Германия)
      'KL8CD6SA1MC123456', // (Chevrolet, 2021, Южная Корея)
      'SALCR2BG1KH123456', // (Land Rover, 2019, Великобритания)
      'WP0AA2A94LS123456', // (Porsche, 2020, Германия)
      '3GCUKREC5GG123456', // (GMC, 2016, Мексика)
      'JN8AY2NF4K9123456', // (Infiniti, 2019, Япония)
      'SHHFK8G73LU123456' // (Honda Civic Type R, 2020, Великобритания)
    };
    var rnd = Random();

    int index = rnd.nextInt(vinList.length - 1);
    String vin = vinList.elementAt(index);
    return vin;
  }
}
