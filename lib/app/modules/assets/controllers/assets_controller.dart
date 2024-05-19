import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tractian_challenge/utils/constants.dart';

class AssetsController extends GetxController {
  final String companyId;

  AssetsController(this.companyId);

  var assets = <Assets>[].obs; // Alteração de RxList para List

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse(Constants.assetsApiUrl(companyId)));
      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            json.decode(response.body) as List<dynamic>;
        if (responseData.isNotEmpty) {
          assets.value = responseData.map((e) => Assets.fromJson(e)).toList();
        }
      } else {
        print('Failed to load assets: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading assets: $e');
    }
  }
}

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
