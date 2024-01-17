import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/features/address/presentation/bloc/address_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  // final String? streetName;
  final String? city;
  final String? postalCode;
  final String? state_;
  final String? country;
  final double? latitude;
  final double? longitude;

  const AddAddressPage({
    super.key,
    // required this.streetName,
    required this.city,
    required this.postalCode,
    required this.state_,
    required this.country,
    required this.latitude,
    required this.longitude,
  });
  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  late TextEditingController nameController;
  // late TextEditingController unitController;
  late TextEditingController addressController;
  late TextEditingController noteController;

  // Controllers for fixed fields
  // late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController postalCodeController;
  late TextEditingController stateController;
  late TextEditingController countryController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    // unitController = TextEditingController();
    addressController = TextEditingController();
    noteController = TextEditingController();
    // streetController = TextEditingController();
    cityController = TextEditingController();
    postalCodeController = TextEditingController();
    stateController = TextEditingController();
    countryController = TextEditingController();
  }

  void _validateInputs() {
    if (nameController.text.isEmpty && addressController.text.isEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: const Text('Name and Address are required fields.'),
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
    } else if (nameController.text.isEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: const Text('Name is required field.'),
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
    } else if (addressController.text.isEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: const Text('Address is required field.'),
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
    } else {
      BlocProvider.of<AddressBloc>(context).add(AddAddress(
        name: nameController.text,
        // unit: unitController.text,
        // streetName: streetController.text,
        address: addressController.text,
        city: cityController.text,
        postalCode: postalCodeController.text,
        state: stateController.text,
        country: countryController.text,
        note: noteController.text,
        latitude: widget.latitude!,
        longitude: widget.longitude!,
      ));

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Address added successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // GoRouter.of(context).go('/address');
                  GoRouter.of(context).pop();
                  GoRouter.of(context).pop();
                  GoRouter.of(context).pop();
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
        centerTitle: true,
        title: const Text('Bookmark Address'),
      ),
      body: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          if (state is AddressInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddressesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddressesLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Information Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 200, // Adjust the height as needed
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(widget.latitude!, widget.longitude!),
                          zoom: 16.0,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('selected_location'),
                            position:
                                LatLng(widget.latitude!, widget.longitude!),
                          ),
                        },
                        zoomGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        zoomControlsEnabled: false,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildTextField("Name*", nameController,
                        'Save address as ...', 'e.g.: Home, Office'),
                    const SizedBox(height: 24),
                    // _buildTextField("Unit*", unitController, '', ''),
                    _buildTextField("Address*", addressController,
                        'Your address ...', 'e.g.: unit, block, street'),
                    // const SizedBox(height: 4),
                    // _buildFixedTextField(
                    //     "Street Name", streetController, widget.streetName),
                    const SizedBox(height: 24),
                    _buildFixedTextField("City", cityController, widget.city),
                    const SizedBox(height: 24),
                    _buildFixedTextField(
                        "Postal Code", postalCodeController, widget.postalCode),
                    const SizedBox(height: 24),
                    _buildFixedTextField(
                        "State", stateController, widget.state_),
                    const SizedBox(height: 24),
                    _buildFixedTextField(
                        "Country", countryController, widget.country),
                    const SizedBox(height: 24),
                    _buildTextField(
                        "Note (Optional)",
                        noteController,
                        'Add delivery instructions ...',
                        'e.g.: nearest building, nearest place'),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: BottomAppBar(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _validateInputs();
              },
              child: const Text('Save Address'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      String? hintText, String? helperText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText,
        hintText: hintText ?? '',
        hintStyle: const TextStyle(color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildFixedTextField(
      String label, TextEditingController controller, String? initialValue) {
    controller.text = initialValue ?? '';
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        enabled: false,
      ),
    );
  }
}
