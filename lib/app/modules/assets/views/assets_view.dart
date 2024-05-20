import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_image_view.dart';
import '../controllers/assets_controller.dart';
import '../models/assets_model.dart';
import '../models/locations_model.dart';

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
      body: Obx(
        () {
          if (controller.assets.isEmpty || controller.locations.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: controller.updateSearchQuery,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    spacing: 8.0,
                    children: [
                      FilterChip(
                        label: const Text('Crítico'),
                        selected: controller.isAlertSelected.value,
                        onSelected: (bool selected) {
                          controller.updateFilter('status', selected);
                        },
                      ),
                      FilterChip(
                        label: const Text('Sensor de Energia'),
                        selected: controller.isSensorTypeSelected.value,
                        onSelected: (bool selected) {
                          controller.updateFilter('sensorType', selected);
                        },
                      ),
                      // Adicione mais chips de filtro conforme necessário
                    ],
                  ),
                ),
                Expanded(
                  child: TreeView(
                    assets: controller.filteredAssets,
                    locations: controller.filteredLocations,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class TreeView extends StatelessWidget {
  final List<Assets> assets;
  final List<Locations> locations;
  final double nodeIndent;

  const TreeView({
    super.key,
    required this.assets,
    required this.locations,
    this.nodeIndent = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...locations.where((loc) => loc.parentId == null).map(
            (location) => buildLocationNode(location, locations, assets, 0.0)),
        ...assets
            .where(
                (asset) => asset.locationId == null && asset.parentId == null)
            .map((asset) => buildAssetNode(asset, assets, 0.0)),
      ],
    );
  }

  Widget buildLocationNode(Locations location, List<Locations> allLocations,
      List<Assets> allAssets, double marginLeft) {
    List<Widget> children = [];

    List<Locations> directChildLocations =
        allLocations.where((loc) => loc.parentId == location.id).toList();
    for (var childLocation in directChildLocations) {
      children.add(buildLocationNode(
          childLocation, allLocations, allAssets, marginLeft + nodeIndent));
    }

    List<Assets> locationAssets =
        allAssets.where((ass) => ass.locationId == location.id).toList();
    for (var asset in locationAssets) {
      children.add(buildAssetNode(asset, allAssets, marginLeft + nodeIndent));
    }

    return LocationNode(
      location: location,
      childNodes: children,
      marginLeft: marginLeft,
      nodeIndent: nodeIndent,
    );
  }

  Widget buildAssetNode(
      Assets asset, List<Assets> allAssets, double marginLeft) {
    List<Widget> children = [];

    List<Assets> directChildAssets =
        allAssets.where((ass) => ass.parentId == asset.id).toList();
    for (var childAsset in directChildAssets) {
      children
          .add(buildAssetNode(childAsset, allAssets, marginLeft + nodeIndent));
    }

    return AssetNode(
      asset: asset,
      childNodes: children,
      marginLeft: marginLeft,
      nodeIndent: nodeIndent,
    );
  }
}

class LocationNode extends StatefulWidget {
  final Locations location;
  final List<Widget> childNodes;
  final double marginLeft;
  final double nodeIndent;

  const LocationNode({
    super.key,
    required this.location,
    required this.childNodes,
    required this.marginLeft,
    required this.nodeIndent,
  });

  @override
  _LocationNodeState createState() => _LocationNodeState();
}

class _LocationNodeState extends State<LocationNode> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: widget.marginLeft),
          child: ListTile(
            tileColor: theme.scaffoldBackgroundColor,
            contentPadding: EdgeInsets.only(
                left: widget.childNodes.isNotEmpty ? 0.w : 14.w),
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.childNodes.isNotEmpty)
                  IconButton(
                    icon: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: theme.colorScheme.secondary,
                      size: 20.w,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  ),
                Icon(
                  Icons.location_on_outlined,
                  color: theme.primaryColor,
                ),
              ],
            ),
            title: Text(
              widget.location.name ?? 'No Name',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                height: 1.22.h,
                fontWeight: FontWeight.normal,
              ),
            ),
            onTap: () {
              if (widget.childNodes.isNotEmpty) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }
            },
          ),
        ),
        if (_isExpanded)
          Padding(
            padding:
                EdgeInsets.only(left: widget.marginLeft + widget.nodeIndent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.childNodes,
            ),
          ),
      ],
    );
  }
}

class AssetNode extends StatefulWidget {
  final Assets asset;
  final List<Widget> childNodes;
  final double marginLeft;
  final double nodeIndent;

  const AssetNode({
    super.key,
    required this.asset,
    required this.childNodes,
    required this.marginLeft,
    required this.nodeIndent,
  });

  @override
  _AssetNodeState createState() => _AssetNodeState();
}

class _AssetNodeState extends State<AssetNode> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    IconData? getIcon() {
      if (widget.asset.sensorType == "vibration" &&
          widget.asset.status == "alert") {
        return Icons.circle;
      } else if (widget.asset.sensorType != null) {
        return Icons.bolt;
      }
      return null;
    }

    Color? getIconColor() {
      if (widget.asset.sensorType == "vibration" &&
          widget.asset.status == "alert") {
        return const Color(0xFFED3833);
      } else if (widget.asset.sensorType != null) {
        return const Color(0xFF52C41A);
      }
      return null;
    }

    double? getIconSize() {
      if (widget.asset.sensorType == "vibration" &&
          widget.asset.status == "alert") {
        return 12.w;
      } else if (widget.asset.sensorType != null) {
        return 20.w;
      }
      return null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: widget.marginLeft),
          child: ListTile(
            tileColor: theme.scaffoldBackgroundColor,
            contentPadding: EdgeInsets.only(
                left: widget.childNodes.isNotEmpty ? 0.w : 14.w, right: 16.0.w),
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.childNodes.isNotEmpty)
                  IconButton(
                    icon: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: theme.colorScheme.secondary,
                      size: 20.w,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  ),
                if (widget.asset.sensorType != null)
                  CustomImageView(
                    imagePath: Constants.codepen,
                    width: 24,
                  )
                else
                  CustomImageView(
                    svgPath: Constants.ioCubeOutline,
                    width: 24,
                  ),
              ],
            ),
            title: Row(
              children: [
                Flexible(
                  child: Text(
                    widget.asset.name ?? 'No Name',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      height: 1.22.h,
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                8.horizontalSpace,
                if (getIcon() != null)
                  Icon(
                    getIcon(),
                    color: getIconColor(),
                    size: getIconSize(),
                  ),
              ],
            ),
            dense: true,
            onTap: () {
              if (widget.childNodes.isNotEmpty) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }
            },
          ),
        ),
        if (_isExpanded)
          Padding(
            padding:
                EdgeInsets.only(left: widget.marginLeft + widget.nodeIndent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.childNodes,
            ),
          ),
      ],
    );
  }
}
