//  отделка
class Trim {
  int id = 0;
  int make_model_id = 0;
  int year = 0;
  String name = '';
  String description = '';
  int msrp = 0;
  int invoice = 0;
  String model_name = '';
  int make_id = 0;
  String make_name = '';

  Trim.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        make_model_id = json['make_model_id'] as int,
        year = json['year'] as int,
        name = json['name'] as String,
        description = json['description'] as String,
        msrp = json['msrp'] as int,
        invoice = json['invoice'] as int,
        model_name = json['make_model']['name'] as String,
        make_id = json['make_model']['make_id'] as int,
        make_name = json['make_model']['make']['name'] as String;

  static List<Trim> fromListJson(List<dynamic> listJson) {
    List<Trim> listTrim = [];

    listJson.forEach((value) {
      Trim trim = Trim.fromJson(value);
      listTrim.add(trim);
    });

    return listTrim;
  }

  Trim(this.id, this.make_model_id, this.year, this.name, this.description,
      this.msrp, this.invoice, this.model_name, this.make_id, this.make_name);

  Trim.empty() {
    id = 0;
    make_model_id = 0;
    year = 0;
    name = '';
    description = '';
    msrp = 0;
    invoice = 0;
    model_name = '';
    make_id = 0;
    make_name = '';
  }

  @override
  String toString() {
    return 'id = $id, make_model_id = $make_model_id, year = $year, name = $name, description = $description, msrp = $msrp, invoice = $invoice, model_name = $model_name, make_id = $make_id, make_name = $make_name ';
  }
}
