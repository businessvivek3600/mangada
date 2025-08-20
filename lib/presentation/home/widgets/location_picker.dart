import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerScreen extends StatefulWidget {
  final LatLng initialPosition;

  const LocationPickerScreen({super.key, required this.initialPosition});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late LatLng _pickedLocation;

  @override
  void initState() {
    super.initState();
    _pickedLocation = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.initialPosition,
          zoom: 14,
        ),
        onTap: (pos) {
          setState(() => _pickedLocation = pos);
        },
        markers: {
          Marker(
            markerId: const MarkerId("picked"),
            position: _pickedLocation,
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, _pickedLocation);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
