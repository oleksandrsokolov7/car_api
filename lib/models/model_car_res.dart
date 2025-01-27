import 'package:car_api/models/model_car.dart';

class ModelCarRequestRes {
  List<ModelCar> list = [];
  String message = '';
  int status = 0;
  int pages_total = 1;
  int total_item = 0;
  int curr_page = 0;
  int page_size = 0;

  ModelCarRequestRes(this.list, this.message, this.status);
  ModelCarRequestRes.empty() {
    list = [];
    message = '';
    status = 0;
  }

  @override
  String toString() {
    return 'list = $list, message = $message, status = $status';
  }
}
