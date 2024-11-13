import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  final Function(LatLng) onLocationSelected;

  const MapSample({Key? key, required this.onLocationSelected}) : super(key: key);

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  Location location = Location();
  StreamSubscription<LocationData>? locationSubscription;
  CameraPosition? initialCameraPosition;

  @override
  void initState() {
    super.initState();
    setupCurrentLocation();
  }

  Future<void> setupCurrentLocation() async {
    bool permissionGranted = await _checkPermission();
    bool serviceEnabled = await _enableService();

    if (!permissionGranted || !serviceEnabled) return;

    LocationData locationData = await location.getLocation();
    initialCameraPosition = CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: 14.4746,
    );

    setState(() {
      markers.add(Marker(
        markerId: MarkerId("currentLocation"),
        position: LatLng(locationData.latitude!, locationData.longitude!),
      ));
    });

    locationSubscription = location.onLocationChanged.listen((event) {
      _updateMarker(LatLng(event.latitude!, event.longitude!));
    });
  }

  Future<bool> _checkPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _enableService() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  void _updateMarker(LatLng position) {
    setState(() {
      markers.add(Marker(
        markerId: MarkerId("selectedLocation"),
        position: position,
      ));
    });
    widget.onLocationSelected(position);
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialCameraPosition ?? CameraPosition(target: LatLng(0, 0), zoom: 2),
      mapType: MapType.normal,
      markers: markers,
      onTap: (position) {
        _updateMarker(position);
      },
      onMapCreated: (controller) => _controller.complete(controller),
    );
  }
}



