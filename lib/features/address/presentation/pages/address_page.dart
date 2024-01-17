import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/config/routes/app_router_constants.dart';
import 'package:fruit_jus_168/features/address/presentation/bloc/address_bloc.dart';
import 'package:fruit_jus_168/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:location/location.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});
  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  late Location location;
  int selectedAddressIndex = -1;

  @override
  void initState() {
    super.initState();
    location = Location();
    BlocProvider.of<AddressBloc>(context).add(GetAddresses());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is DefaultAddressUpdated) {
          final defaultAddress = state.address;
          context.read<CartBloc>().add(
                FullfillmentChange(
                    deliveryMethod: "delivery",
                    address: defaultAddress.fullAddress),
              );
          context.goNamed(AppRouterConstants.menuRouteName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Set Your Address',
          ),
        ),
        body: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            if (state is AddressInitial ||
                state is AddressesLoading ||
                state is DefaultAddressUpdated) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AddressesLoaded) {
              if (state.addresses.isEmpty) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'Saved Addresses',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 80),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 36,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Add your address and have your order delivered to your doorstep',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            _checkLocationPermissionAndNavigate();
                          },
                          child: const Text(
                            '+ Add New Address',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                selectedAddressIndex =
                    state.addresses.indexWhere((address) => address.isDefault!);
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Row(
                          children: [
                            Text(
                              // 'Saved Addresses  [${state.addresses.length}]',
                              'Saved Addresses',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.addresses.length,
                          itemBuilder: (context, index) {
                            final address = state.addresses[index];
                            return Column(
                              children: [
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: () {
                                    // Trigger onChanged when the user taps on the radio or the ListTile
                                    setState(() {
                                      selectedAddressIndex = index;
                                    });
                                    BlocProvider.of<AddressBloc>(context).add(
                                      UpdateDefaultAddress(
                                          addressId: address.id!),
                                    );
                                  },
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Radio(
                                      value: index,
                                      groupValue: selectedAddressIndex,
                                      onChanged: (int? value) {
                                        setState(() {
                                          selectedAddressIndex = value ?? -1;
                                          BlocProvider.of<AddressBloc>(context)
                                              .add(
                                            UpdateDefaultAddress(
                                                addressId: address.id!),
                                          );
                                        });
                                      },
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${address.name}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          address.fullAddress,
                                          style: const TextStyle(
                                              fontSize: 11, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    trailing: PopupMenuButton<String>(
                                      onSelected: (String result) {
                                        if (result == 'edit') {
                                          BlocProvider.of<AddressBloc>(context)
                                              .add(GetAddresses(
                                                  addressId: address.id!));
                                          GoRouter.of(context)
                                              .push('/edit-address');
                                        } else if (result == 'delete') {
                                          BlocProvider.of<AddressBloc>(context)
                                              .add(DeleteAddress(
                                                  addressId: address.id!));
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Success'),
                                                content: const Text(
                                                    'Address deleted successfully.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      GoRouter.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuEntry<String>>[
                                        const PopupMenuItem<String>(
                                          value: 'edit',
                                          child: ListTile(
                                            leading: Icon(Icons.edit),
                                            title: Text('Edit'),
                                          ),
                                        ),
                                        const PopupMenuItem<String>(
                                          value: 'delete',
                                          child: ListTile(
                                            leading: Icon(Icons.delete),
                                            title: Text('Delete'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              }
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
                  _checkLocationPermissionAndNavigate();
                },
                child: const Text('+ Add New Address'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _checkLocationPermissionAndNavigate() async {
    final status = await permission_handler.Permission.location.request();

    if (status.isGranted) {
      await location.requestService();
      if (await location.serviceEnabled()) {
        if (context.mounted) {
          GoRouter.of(context).push('/open-map');
        }
      } else {
        showLocationServiceDialog();
      }
    } else {
      showLocationPermissionDeniedDialog();
    }
  }

  void showLocationServiceDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Service Disabled'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Please enable location services to use this feature.'),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        );
      },
    );
  }

  void showLocationPermissionDeniedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Denied'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Please grant location permission to use this feature.'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await permission_handler.openAppSettings();
                    },
                    child: const Text('Open Settings'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
