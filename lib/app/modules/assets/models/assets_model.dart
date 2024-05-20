class Assets {
  String? gatewayId;
  String? id;
  String? locationId;
  String? name;
  String? parentId;
  String? sensorId;
  String? sensorType;
  String? status;

  Assets({
    this.gatewayId,
    this.id,
    this.locationId,
    this.name,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
  });

  factory Assets.fromJson(Map<String, dynamic> json) {
    return Assets(
      gatewayId: json['gatewayId'],
      id: json['id'],
      locationId: json['locationId'],
      name: json['name'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'],
    );
  }
}
