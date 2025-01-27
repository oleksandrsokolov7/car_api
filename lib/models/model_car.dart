class ModelCar {
  int id = 0;
  String name = '';
  int make_id = 0;
  String make_name = '';

  ModelCar(this.id, this.name, this.make_id, this.make_name);

  ModelCar.empty() {
    id = 0;
    name = '';
    make_id = 0;
    make_name = '';
  }

  ModelCar.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        make_id = json['make_id'] as int,
        make_name = json['make']['name'] as String;

  @override
  String toString() {
    return 'id = $id, name = $name';
  }
}
