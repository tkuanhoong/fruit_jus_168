import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruit_jus_168/features/address/domain/entities/address.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_jus_168/features/address/domain/usecases/add_address.dart';
import 'package:fruit_jus_168/features/address/domain/usecases/delete_address.dart';
import 'package:fruit_jus_168/features/address/domain/usecases/edit_address.dart';
import 'package:fruit_jus_168/features/address/domain/usecases/get_address.dart';
import 'package:fruit_jus_168/features/address/domain/usecases/get_addresses.dart';
import 'package:fruit_jus_168/features/address/domain/usecases/update_default_address.dart';
part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetAddressesUseCase getAddressesUseCase;
  final GetAddressUseCase getAddressUseCase;
  final AddAddressUseCase addAddressUseCase;
  final EditAddressUseCase editAddressUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  final UpdateDefaultAddressUseCase updateDefaultAddressUseCase;

  AddressBloc(
      {required this.getAddressesUseCase,
      required this.getAddressUseCase,
      required this.addAddressUseCase,
      required this.editAddressUseCase,
      required this.deleteAddressUseCase,
      required this.updateDefaultAddressUseCase})
      : super(AddressInitial()) {
    on<GetAddresses>((event, emit) async {
      emit(AddressesLoading());
      try {
        final List<AddressEntity> addresses = await getAddressesUseCase.call();
        if (event.addressId != null) {
          final AddressEntity address =
              await getAddressUseCase.call(event.addressId!);
          emit(AddressesLoaded(addresses: addresses, address: address));
        } else {
          emit(AddressesLoaded(addresses: addresses));
        }
      } catch (e) {
        emit(AddressError(errorMessage: 'Failed to load address.'));
      }
    });

    on<AddAddress>((event, emit) async {
      emit(AddressesLoading());
      try {
        final address = AddressEntity(
          id: null,
          name: event.name,
          // unit: event.unit,
          // streetName: event.streetName,
          address: event.address,
          city: event.city,
          postalCode: event.postalCode,
          state: event.state,
          country: event.country,
          note: event.note,
          isDefault: false,
          createdAt: Timestamp.now(),
          latitude: event.latitude,
          longitude: event.longitude,
        );
        await addAddressUseCase.call(address);
        final List<AddressEntity> addresses = await getAddressesUseCase.call();
        emit(AddressesLoaded(addresses: addresses));
      } catch (e) {
        emit(AddressError(errorMessage: 'Failed to add address.'));
      }
    });

    on<EditAddress>((event, emit) async {
      emit(AddressesLoading());
      try {
        final address = AddressEntity(
          id: event.id,
          name: event.name,
          // unit: event.unit,
          // streetName: event.streetName,
          address: event.address,
          city: event.city,
          postalCode: event.postalCode,
          state: event.state,
          country: event.country,
          note: event.note,
          isDefault: event.isDefault,
          createdAt: event.createdAt,
          latitude: event.latitude,
          longitude: event.longitude,
        );
        await editAddressUseCase.call(address);
        final List<AddressEntity> addresses = await getAddressesUseCase.call();
        emit(AddressesLoaded(addresses: addresses, address: address));
      } catch (e) {
        emit(AddressError(errorMessage: 'Failed to edit address.'));
      }
    });

    on<DeleteAddress>((event, emit) async {
      emit(AddressesLoading());
      try {
        await deleteAddressUseCase.call(event.addressId);
        final List<AddressEntity> addresses = await getAddressesUseCase.call();
        emit(AddressesLoaded(addresses: addresses));
      } catch (e) {
        emit(AddressError(errorMessage: 'Failed to delete address.'));
      }
    });

    on<UpdateDefaultAddress>((event, emit) async {
      emit(AddressesLoading());
      try {
        await updateDefaultAddressUseCase.call(event.addressId);
        final List<AddressEntity> addresses = await getAddressesUseCase.call();
        emit(AddressesLoaded(addresses: addresses));
      } catch (e) {
        emit(AddressError(errorMessage: 'Failed to update default address.'));
      }
    });
  }
}
