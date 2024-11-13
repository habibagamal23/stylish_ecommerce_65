import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Function(LatLng) onLocationSelected;

  const MapScreen({Key? key, required this.onLocationSelected}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  final loc.Location _location = loc.Location();
  CameraPosition? _initialCameraPosition;
  StreamSubscription<loc.LocationData>? _locationSubscription;
  String? _selectedAddress;
  LatLng? _selectedPosition;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    bool isPermissionGranted = await _checkPermission();
    bool isServiceEnabled = await _enableService();

    if (isPermissionGranted && isServiceEnabled) {
      final locationData = await _location.getLocation();
      _initialCameraPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 14.4746,
      );

      // Update marker and move camera to the initial location
      _updateMarker(locationData.latitude!, locationData.longitude!, moveCamera: true);
      setState(() {}); // Ensure the map rebuilds with the initial camera position
    } else {
      // Fallback to a default location if permissions or service is denied
      _initialCameraPosition = CameraPosition(
        target: LatLng(30.081591, 31.329016), // San Francisco as a fallback location
        zoom: 10.0,
      );
      setState(() {}); // Update the map with the fallback position
    }
  }

  Future<void> _updateMarker(double lat, double lng, {bool moveCamera = false}) async {
    _selectedPosition = LatLng(lat, lng);
    final List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    setState(() {
      _markers = {
        Marker(
          markerId: MarkerId('selectedLocation'),
          position: _selectedPosition!,
        ),
      };
      _selectedAddress = placemarks.isNotEmpty
          ? "${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}"
          : "Unknown location";
    });

    if (moveCamera) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLng(_selectedPosition!));
    }

    widget.onLocationSelected(_selectedPosition!);
  }

  Future<bool> _checkPermission() async {
    var permissionStatus = await _location.hasPermission();
    if (permissionStatus == loc.PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
    }
    return permissionStatus == loc.PermissionStatus.granted;
  }

  Future<bool> _enableService() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
    }
    return serviceEnabled;
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
      ),
      body: _initialCameraPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCameraPosition!,
            mapType: MapType.normal,
            markers: _markers,
            zoomControlsEnabled: true,
            onTap: (position) => _updateMarker(position.latitude, position.longitude),
            onMapCreated: (controller) => _controller.complete(controller),
          ),
          if (_selectedAddress != null)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white.withOpacity(0.9),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Selected Address:", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(_selectedAddress!),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (_selectedPosition != null) {
                          widget.onLocationSelected(_selectedPosition!);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text("Confirm Location"),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
