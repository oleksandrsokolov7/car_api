class Makes {
  int id = 0;
  String name = '';

  Makes(this.id, this.name);
  Makes.empty() {
    id = 0;
    name = '';
  }

  Makes.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  String toString() {
    return 'id = $id, name = $name';
  }
}
