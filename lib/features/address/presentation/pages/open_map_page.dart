import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class OpenMapPage extends StatefulWidget {
  const OpenMapPage({Key? key}) : super(key: key);

  @override
  State<OpenMapPage> createState() => _OpenMapPageState();
}

class _OpenMapPageState extends State<OpenMapPage> {
  final Completer<GoogleMapController> _controllerCompleter =
      Completer<GoogleMapController>();
  late LatLng _selectedLocation = const LatLng(10.0, 10.0);
  late Marker _marker = Marker(
    markerId: const MarkerId('selected_location'),
    position: _selectedLocation,
    draggable: true,
  );
  TextEditingController _searchController = TextEditingController();
  // late String _streetName = '';
  late String? _city = '';
  late String? _postalCode = '';
  late String? _state = '';
  late String? _country = '';
  List<Placemark> _placemarks = [];
  late double? latitude = 0.0;
  late double? longitude = 0.0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Update _selectedLocation
      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
        _marker = _marker.copyWith(positionParam: _selectedLocation);
      });

      // Move the map camera to the current location
      final GoogleMapController controller = await _controllerCompleter.future;
      await controller.moveCamera(
        CameraUpdate.newLatLng(_selectedLocation),
      );

      updatePlacemarks();
    } catch (e) {
      print("Error getting current location: $e");
    }
  }

  void updatePlacemarks() async {
    // Get address details using geocoding
    _placemarks = await placemarkFromCoordinates(
      _selectedLocation.latitude,
      _selectedLocation.longitude,
    );

    // Extract address details
    if (_placemarks.isNotEmpty) {
      Placemark firstPlacemark = _placemarks.first;
      // _streetName = firstPlacemark.street ?? '';
      _city = firstPlacemark.locality ?? '';
      _postalCode = firstPlacemark.postalCode ?? '';
      _state = firstPlacemark.administrativeArea ?? '';
      _country = firstPlacemark.country ?? '';
    }

    latitude = _selectedLocation.latitude;
    longitude = _selectedLocation.longitude;
  }

  void _updateSelectedLocation(CameraPosition position) {
    setState(() {
      _selectedLocation = position.target;
      _marker = _marker.copyWith(positionParam: _selectedLocation);
      updatePlacemarks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Choose Delivery Address'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              _controllerCompleter.complete(controller);
            },
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 15,
            ),
            onCameraMove: (CameraPosition position) {
              _updateSelectedLocation(position);
            },
            markers: {
              _marker,
            },
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search location...',
                        suffixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        // _searchLocation(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 80,
            right: 80,
            child: ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push(
                    '/add-address/$_city/$_postalCode/$_state/$_country/$latitude/$longitude');
              },
              child: const Text('Confirm'),
            ),
          ),
        ],
      ),
    );
  }
}
