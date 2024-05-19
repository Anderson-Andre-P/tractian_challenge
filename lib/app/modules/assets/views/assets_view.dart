import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/assets_controller.dart';

class AssetsView extends StatelessWidget {
  const AssetsView({super.key});

  @override
  Widget build(BuildContext context) {
    final AssetsController controller = Get.find<AssetsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets View'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.assets.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return TreeView(locations: controller.assets);
        }
      }),
    );
  }
}

class TreeView extends StatelessWidget {
  final List<Assets> locations;
  final double nodeIndent;

  const TreeView({
    super.key,
    required this.locations,
    this.nodeIndent = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: locations
          .where((loc) => loc.parentId == null)
          .map((location) => buildNode(location, locations, 0.0))
          .toList(),
    );
  }

  Widget buildNode(
      Assets location, List<Assets> allLocations, double marginLeft) {
    List<Widget> children = [];

    List<Assets> directChildren =
        allLocations.where((loc) => loc.parentId == location.id).toList();

    for (var child in directChildren) {
      children.add(buildNode(child, allLocations, marginLeft + nodeIndent));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: marginLeft),
          child: ListTile(
            title: Text(location.name ?? 'No Name'),
            subtitle: Text(location.locationId != null
                ? '[Location]'
                : location.sensorType != null
                    ? '[Component - ${location.sensorType}]'
                    : '[Asset]'),
          ),
        ),
        if (children.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: marginLeft + nodeIndent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
      ],
    );
  }
}
