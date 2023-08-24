import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class MapSection extends StatefulWidget {
  const MapSection({Key? key}) : super(key: key);

  @override
  _MapSectionState createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  late MapController _mapController;
  Position? _currentPosition;

  @override
  void initState() {
    _mapController = MapController();

    _checkLocationPermission();

    super.initState();
  }

  void _checkLocationPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
        await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high
        ).then((Position position) {
          _mapController.move(LatLng(position.latitude, position.longitude), 12);
          setState(() => _currentPosition = position);
        }).catchError((e) {
          debugPrint(e);
        });
      } else if (status.isDenied) {
        Map<Permission, PermissionStatus> status = await [
          Permission.location,
        ].request();
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(-6.1595214, 106.8247346),
          zoom: 5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          _currentPosition != null ? MarkerLayer(
            markers: [
              Marker(
                point: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                width: 40,
                height: 40,
                builder: (context) => FlutterLogo(),
              ),
            ],
          ) : const MarkerLayer(),
        ],
      ),
    );
  }
}
