class Locations {
  String? id;
  String? name;
  String? parentId;

  Locations({this.id, this.name, this.parentId});

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}
