import 'package:car_api/models/makes.dart';

class MakesRequestRes {
  List<Makes> list = [];
  String message = '';
  int status = 0;

  MakesRequestRes(this.list, this.message, this.status);
  MakesRequestRes.empty() {
    list = [];
    message = '';
    status = 0;
  }

  @override
  String toString() {
    return 'list = $list, message = $message, status = $status';
  }
}
