import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tractian_challenge/utils/constants.dart';

import '../models/assets_model.dart';
import '../models/locations_model.dart';

class AssetsController extends GetxController {
  final String companyId;

  AssetsController(this.companyId);

  var assets = <Assets>[].obs;
  var locations = <Locations>[].obs;
  var searchQuery = ''.obs;
  var isAlertSelected = false.obs;
  var isSensorTypeSelected = false.obs;

  List<Assets> get filteredAssets {
    final query = searchQuery.value.toLowerCase();

    return assets.where((asset) {
      final assetName = asset.name?.toLowerCase() ?? '';
      final matchesQuery = assetName.contains(query);
      final matchesAlert = isAlertSelected.value
          ? asset.status == 'alert' || asset.status == null
          : true;
      final matchesSensorType =
          isSensorTypeSelected.value ? asset.sensorType == 'energy' : true;

      return matchesQuery && matchesAlert && matchesSensorType;
    }).toList();
  }

  List<Locations> get filteredLocations {
    return locations.where((location) {
      return _locationMatches(location, filteredAssets);
    }).toList();
  }

//   bool _locationMatches(Locations location) {
//     final query = searchQuery.value.toLowerCase();
//     final locationName = location.name?.toLowerCase() ?? '';
//     final matchesQuery = locationName.contains(query);

//     // Verifica se o nome da localização corresponde à consulta de pesquisa
//     if (matchesQuery) {
//       return true;
//     }

//     // Verifica se algum ativo na localização corresponde à consulta e aos filtros
//     final hasMatchingAssets =
//         filteredAssets.any((asset) => asset.locationId == location.id);

//     if (hasMatchingAssets) {
//       return true;
//     }

//     // Verifica se alguma sublocalização corresponde à consulta e aos filtros
//     final hasMatchingSubLocations = locations.any((subLocation) =>
//         subLocation.parentId == location.id && _locationMatches(subLocation));

//     return hasMatchingSubLocations;
//   }

  bool _locationMatches(Locations location, List<Assets> filteredAssetsList) {
    final query = searchQuery.value.toLowerCase();
    final locationName = location.name?.toLowerCase() ?? '';
    final matchesQuery = locationName.contains(query);
    // final matchesQuery = location.name
    //         ?.toLowerCase()
    //         .contains(searchQuery.value.toLowerCase()) ??
    //     true;

    if (matchesQuery) {
      bool hasMatchingAssets =
          filteredAssetsList.any((asset) => asset.locationId == location.id);

      bool hasMatchingSubLocations = locations.any((subLocation) {
        return subLocation.parentId == location.id &&
            _locationMatches(subLocation, filteredAssetsList);
      });

      return hasMatchingAssets || hasMatchingSubLocations;
    }

    return false;
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  void updateFilter(String filter, bool selected) {
    if (filter == 'status') {
      isAlertSelected.value = selected;
    } else if (filter == 'sensorType') {
      isSensorTypeSelected.value = selected;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.wait([fetchAssets(), fetchLocations()]);
  }

  Future<void> fetchAssets() async {
    try {
      final response =
          await http.get(Uri.parse(Constants.assetsApiUrl(companyId)));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        if (responseData.isNotEmpty) {
          final List<Assets> fetchedAssets =
              responseData.map((e) => Assets.fromJson(e)).toList();
          assets.value = fetchedAssets;
        }
      } else {
        // print('Failed to load assets: ${response.statusCode}');
      }
    } catch (e) {
      //   print('Error loading assets: $e');
    }
  }

  Future<void> fetchLocations() async {
    try {
      final response =
          await http.get(Uri.parse(Constants.locationsApiUrl(companyId)));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        if (responseData.isNotEmpty) {
          final List<Locations> fetchedLocations =
              responseData.map((e) => Locations.fromJson(e)).toList();
          locations.value = fetchedLocations;

          // Após atualizar os locais, atualize também os ativos
          await fetchAssets();
        }
      } else {
        print('Failed to load locations: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading locations: $e');
    }
  }
}
