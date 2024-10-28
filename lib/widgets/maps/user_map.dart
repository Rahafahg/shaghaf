import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class UserMap extends StatelessWidget {
  final double lat;
  final double lng;
  const UserMap({super.key, required this.lat, required this.lng});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
        options: MapOptions(
            minZoom: 12.0,
            maxZoom: 17.0,
            initialZoom: 15,
            initialCenter: LatLng(lat, lng),
            interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,)),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
          MarkerLayer(markers: [
            Marker(
                point: LatLng(lat, lng),
                height: 50,
                width: 50,
                alignment: Alignment.topCenter,
                child: const Icon(Icons.location_pin, color: Colors.red, size: 50))
          ])
        ]);
  }
}
