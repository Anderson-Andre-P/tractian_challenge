import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/assets_controller.dart';

class AssetsView extends GetView<AssetsController> {
  const AssetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AssetsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          final assets = controller.assets;

          if (assets.isEmpty) {
            return const Text(
              'No assets available',
              style: TextStyle(fontSize: 20),
            );
          } else {
            final firstAssetName = assets[0]['name'].toString();
            return Text(
              'First Asset Name: $firstAssetName',
              style: const TextStyle(fontSize: 20),
            );
          }
        }),
      ),
    );
  }
}
