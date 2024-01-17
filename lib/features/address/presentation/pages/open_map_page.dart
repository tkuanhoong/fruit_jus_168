import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart' as loc;
import 'package:geocoding/geocoding.dart' as a;
import 'package:go_router/go_router.dart';
import 'package:google_api_headers/google_api_headers.dart' as header;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:location/location.dart' as locator;
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class OpenMapPage extends StatefulWidget {
  const OpenMapPage({super.key});

  @override
  State<OpenMapPage> createState() => _OpenMapPageState();
}

class _OpenMapPageState extends State<OpenMapPage> {
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();
  locator.Location location = locator.Location();
  final Map<String, Marker> _markers = {};
  bool isInitialLocationObtained = false;
  double latitude = 4.1093195;
  double longitude = 109.45547499999998;
  GoogleMapController? _controller;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(4.1093195, 109.45547499999998),
    zoom: 10,
  );
  Future<void> _handleSearch() async {
    places.Prediction? p = await loc.PlacesAutocomplete.show(
        context: context,
        apiKey: 'AIzaSyCimTuJIv9A3aEXUDii8pSfapCINsIhhZc',
        onError: onError, // call the onError function below
        mode: loc.Mode.overlay,
        language: 'en', //you can set any language for search
        strictbounds: false,
        types: [],
        decoration: InputDecoration(
            hintText: 'search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white))),
        components: [
          Component(Component.country, "my")
        ] // you can determine search for just one country
        );
    if (p == null) {
      return;
    }
    displayPrediction(p, homeScaffoldKey.currentState);
  }

  void onError(places.PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Message',
        message: response.errorMessage!,
        contentType: ContentType.failure,
      ),
    ));
  }

  Future<void> displayPrediction(
      places.Prediction p, ScaffoldState? currentState) async {
    places.GoogleMapsPlaces _places = places.GoogleMapsPlaces(
        apiKey: 'AIzaSyCimTuJIv9A3aEXUDii8pSfapCINsIhhZc',
        apiHeaders: await const header.GoogleApiHeaders().getHeaders());
    places.PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
// detail will get place details that user chose from Prediction search
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    _markers.clear(); //clear old marker and set new one
    final marker = Marker(
      markerId: const MarkerId('deliveryMarker'),
      position: LatLng(lat, lng),
      infoWindow: const InfoWindow(
        title: '',
      ),
    );
    setState(() {
      _markers['myLocation'] = marker;
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(lat, lng), zoom: 15),
        ),
      );
      latitude = lat;
      longitude = lng;
    });
  }

  getCurrentLocation() async {
    bool serviceEnabled;
    locator.PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == locator.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != locator.PermissionStatus.granted) {
        return;
      }
    }

    locator.LocationData currentPosition = await location.getLocation();
    latitude = currentPosition.latitude!;
    longitude = currentPosition.longitude!;
    final marker = Marker(
      markerId: const MarkerId('myLocation'),
      position: LatLng(latitude, longitude),
      // infoWindow: const InfoWindow(
      //   title: 'you can add any message here',
      // ),
    );
    setState(() {
      _markers['myLocation'] = marker;
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 15),
        ),
      );
      isInitialLocationObtained = true;
    });
  }

  void _onConfirmButtonPressed() async {
    try {
      // Get location details using geocoding placemark
      List<a.Placemark> placemarks = await a.placemarkFromCoordinates(
        // currentLocation.latitude,
        // currentLocation.longitude,
        latitude, longitude,
      );
      print(latitude);
      print(longitude);

      if (placemarks.isNotEmpty) {
        // Extract location details
        a.Placemark place = placemarks.first;
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
          '/add-address/$city/$postalCode/$state/$country/$latitude/$longitude',
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

  void _onCameraMove(CameraPosition position) {
    setState(() {
      latitude = position.target.latitude;
      longitude = position.target.longitude;
    });
    // final marker = Marker(
    //   markerId: const MarkerId('myLocation'),
    //   position: LatLng(latitude, longitude),
    //   // infoWindow: const InfoWindow(
    //   //   title: 'AppLocalizations.of(context).will_deliver_here',
    //   // ),
    // );
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey, // Add this line
      appBar: AppBar(
        title: const Text('Choose Delivery Address'),
      ),
      body: Stack(children: [
        Container(
          // margin: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: double.infinity,
          child: GoogleMap(
            onCameraMove: _onCameraMove,
            mapType: MapType.normal,
            myLocationEnabled: true,
            initialCameraPosition: _kGooglePlex,
            // markers: _markers.values.toSet(),
            markers: {
              Marker(
                markerId: const MarkerId('user_location'),
                position: LatLng(latitude, longitude),
              ),
            },
            onTap: (LatLng latlng) {
              latitude = latlng.latitude;
              longitude = latlng.longitude;
              final marker = Marker(
                markerId: const MarkerId('myLocation'),
                position: LatLng(latitude, longitude),
                // infoWindow: const InfoWindow(
                //   title: 'AppLocalizations.of(context).will_deliver_here',
                // ),
              );
              setState(() {
                _markers['myLocation'] = marker;
              });
            },
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
            },
          ),
        ),
        Positioned(
          top: 8,
          right: 48,
          child: IconButton(
            // iconSize: 24,
            icon: Icon(Icons.search),
            onPressed: _handleSearch,
          ),
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
      ]),
    );
  }
}
