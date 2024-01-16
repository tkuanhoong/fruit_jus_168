import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/features/address/presentation/bloc/address_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  late TextEditingController nameController;
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    noteController = TextEditingController();
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
                          target: LatLng(state.address!.latitude!,
                              state.address!.longitude!),
                          zoom: 15.0,
                        ),
                        markers: {
                          Marker(
                            markerId: const MarkerId('selected_location'),
                            position: LatLng(state.address!.latitude!,
                                state.address!.longitude!),
                          ),
                        },
                        zoomGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        zoomControlsEnabled: false,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 32.0,
                            child: Center(
                              child: Icon(Icons.location_on_outlined),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                '${state.address!.address}, ${state.address!.city}, ${state.address!.postalCode}, ${state.address!.state}, ${state.address!.country}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildTextField(
                        "Name*",
                        nameController,
                        state.address!.name,
                        'Save address as ...',
                        'e.g.: Home, Office'),
                    const SizedBox(height: 24),
                    _buildTextField(
                        "Note (Optional)",
                        noteController,
                        state.address!.note,
                        'Add delivery instruction',
                        'e.g.: nearest building, nearest place'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isEmpty) {
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
                        } else {
                          BlocProvider.of<AddressBloc>(context).add(EditAddress(
                            id: state.address!.id!,
                            name: nameController.text,
                            // unit: state.address!.unit!,
                            // streetName: state.address!.streetName!,
                            address: state.address!.address!,
                            city: state.address!.city!,
                            postalCode: state.address!.postalCode!,
                            state: state.address!.state!,
                            country: state.address!.country!,
                            note: noteController.text,
                            isDefault: state.address!.isDefault!,
                            createdAt: state.address!.createdAt!,
                            latitude: state.address!.latitude!,
                            longitude: state.address!.longitude!,
                          ));

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Success'),
                                content:
                                    const Text('Address edited successfully.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      // GoRouter.of(context).go('/address');
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
                      },
                      child: const Text('Save Address'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      String? initialValue, String? hintText, String? helperText) {
    controller.text = initialValue ?? '';

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        helperText: helperText,
        hintStyle: const TextStyle(color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
