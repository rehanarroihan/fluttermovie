import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapSection extends StatefulWidget {
  const MapSection({Key? key}) : super(key: key);

  @override
  _MapSectionState createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FlutterMap(
        options: MapOptions(
          center: const LatLng(51.5, -0.09),
          zoom: 5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          //MarkerLayer(markers: _markers),
        ],
      ),
    );
  }
}
