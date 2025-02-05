class ReqRes<T> {
  List<T> list = [];
  String message = '';
  int status = 0;

  int pages_total = 1;
  int total_item = 0;
  int curr_page = 0;
  int page_size = 0;

  ReqRes(this.list, this.message, this.status);
  ReqRes.empty() {
    list = [];
    message = '';
    status = 0;
  }

  // Конструктор для одиночного объекта
  ReqRes.single(T item, this.message, this.status) {
    list = [item]; // Помещаем одиночный объект в список
  }

  // Фабричный конструктор для обработки как списка, так и одиночного объекта
  factory ReqRes.fromData(dynamic data, String message, int status) {
    if (data is List<T>) {
      return ReqRes<T>(data, message, status);
    } else if (data is T) {
      return ReqRes<T>.single(data, message, status);
    } else {
      throw ArgumentError('Data must be either a List<$T> or a $T');
    }
  }

  @override
  String toString() {
    return 'list = $list, message = $message, status = $status';
  }
}
