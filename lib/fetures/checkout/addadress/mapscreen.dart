import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final Function(String) onLocationSelected;

  const MapScreen({Key? key, required this.onLocationSelected})
      : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  final loc.Location _location = loc.Location();
  CameraPosition? initialCameraPosition;
  StreamSubscription<loc.LocationData>? _locationSubscription;
  String? Address;
  LatLng? selectedPosition;

  @override
  void initState() {
    super.initState();
    getcurrentlocation();
  }

  Future<void> getcurrentlocation() async {
    bool isPermissionGranted = await _checkPermission();
    bool isServiceEnabled = await _enableService();
    if (isPermissionGranted && isServiceEnabled) {
      final locationData = await _location.getLocation();
      initialCameraPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 14.4746,
      );
      updatmarker(locationData.latitude!, locationData.longitude!);
      setState(() {});
    } else {
      initialCameraPosition = const CameraPosition(
        target: LatLng(30.081591, 31.329016),
        zoom: 10.0,
      );
      setState(() {});
    }
  }

  Future<void> updatmarker(double lat, double lng,
      {bool moveCamera = false}) async {
    selectedPosition = LatLng(lat, lng);
    final List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

    setState(() {
      markers = {
        Marker(
          markerId: MarkerId('1'),
          position: selectedPosition!,
        ),
      };
      Address = placemarks.isNotEmpty
          ? "${placemarks.first.street}, ${placemarks.first.country}, ${placemarks.first.administrativeArea}"
          : "Unknown location";
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(selectedPosition!));

    widget.onLocationSelected(Address!);
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
      body: initialCameraPosition == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: initialCameraPosition!,
                  mapType: MapType.normal,
                  markers: markers,
                  zoomControlsEnabled: true,
                  onTap: (position) =>
                      updatmarker(position.latitude, position.longitude),
                  onMapCreated: (controller) =>
                      _controller.complete(controller),
                ),
                if (Address != null)
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
                          const Text("Selected Address:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          Text(Address!),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              if (Address != null) {
                                widget.onLocationSelected(Address!);
                              }
                              setState(() {});
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
