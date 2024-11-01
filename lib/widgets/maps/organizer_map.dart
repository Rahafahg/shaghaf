import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OrganizerMap extends StatelessWidget {
  LatLng? markerPosition;
  void Function(TapPosition, LatLng)? onTap;

  OrganizerMap({super.key, required this.onTap,  this.markerPosition});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        minZoom: 9.0,
        maxZoom: 17.0,
        initialZoom: 12,
        initialCenter: const LatLng(24.7136, 46.6753),
        onTap: onTap,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(
          markers: markerPosition != null
              ? [
                  Marker(
                    point: markerPosition!,
                    height: 50,
                    width: 50,
                    alignment: Alignment.topCenter,
                    child: const Icon(Icons.location_pin,
                        color: Colors.red, size: 50),
                  ),
                ]
              : [],
        ),
      ],
    );
  }
}
