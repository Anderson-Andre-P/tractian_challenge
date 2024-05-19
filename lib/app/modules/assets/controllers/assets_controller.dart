import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tractian_challenge/utils/constants.dart';

class AssetsController extends GetxController {
  final String companyId;

  AssetsController(this.companyId);

  var assets = [].obs;

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
        final List<dynamic> responseData = json.decode(response.body);
        if (responseData.isNotEmpty) {
          assets.value = responseData;
        } else {
          print('No assets found for company $companyId');
        }
      } else {
        print('Failed to load assets: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading assets: $e');
    }
  }
}
