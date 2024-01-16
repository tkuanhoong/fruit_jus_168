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
  GoogleMapController? mapController;
  LatLng currentLocation = const LatLng(10.0, 10.0);
  bool isInitialLocationObtained = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng newLocation = LatLng(position.latitude, position.longitude);

    setState(() {
      currentLocation = newLocation;
    });

    // Move the camera to the user's current location
    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(newLocation, 15.0),
    );

    setState(() {
      isInitialLocationObtained = true;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      currentLocation = position.target;
    });
  }

  void _onConfirmButtonPressed() async {
    try {
      // Get location details using geocoding placemark
      List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation.latitude,
        currentLocation.longitude,
      );

      if (placemarks.isNotEmpty) {
        // Extract location details
        Placemark place = placemarks.first;
        print(place);
        String? city = place.locality ?? '';
        if (city == '') {
          city = place.subLocality;
        }
        if (city == '') {
          city = ' ';
        }
        String? postalCode = place.postalCode ?? '';
        if (place.postalCode == '') {
          postalCode = ' ';
        }
        String? state = place.administrativeArea ?? '';
        if (place.administrativeArea == '') {
          state = ' ';
        }
        String? country = place.country ?? '';
        if (place.country == '') {
          country = ' ';
        }

        // Pass values to the next page
        GoRouter.of(context).push(
          '/add-address/$city/$postalCode/$state/$country/${currentLocation.latitude}/${currentLocation.longitude}',
        );
      } else {
        // Handle the case when no placemarks are found
        print("No placemarks found for the selected location.");
        // You can show an error message or take appropriate action here.
      }
    } catch (e) {
      // Handle exceptions that may occur during geocoding
      print("Error during geocoding: $e");
      // You can show an error message or take appropriate action here.
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Not valid location'),
            content: const Text('Please select proper location.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Delivery Address'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: currentLocation,
              zoom: 15.0,
            ),
            onCameraMove: _onCameraMove,
            markers: {
              Marker(
                markerId: const MarkerId('user_location'),
                position: currentLocation,
              ),
            },
          ),
          Positioned(
            bottom: 40,
            left: 80,
            right: 80,
            child: ElevatedButton(
              onPressed:
                  isInitialLocationObtained ? _onConfirmButtonPressed : null,
              style: ElevatedButton.styleFrom(
                primary: isInitialLocationObtained
                    ? const Color(0XFF20941C)
                    : Colors.grey,
              ),
              child: const Text('Confirm'),
            ),
          ),
        ],
      ),
    );
  }
}
