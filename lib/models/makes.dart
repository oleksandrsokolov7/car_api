class Makes {
  int id = 0;
  String name = '';
  String picture = '';

  Makes(this.id, this.name, this.picture);
  Makes.empty() {
    id = 0;
    name = '';
    picture = '';
  }

  Makes.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        picture = '';

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'picture': picture};

  @override
  String toString() {
    return 'id = $id, name = $name, picture = $picture';
  }
}
