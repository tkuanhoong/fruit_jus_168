import 'package:fruit_jus_168/features/address/data/datasources/address_datasource.dart';
import 'package:fruit_jus_168/features/address/data/models/address.dart';
import 'package:fruit_jus_168/features/address/domain/entities/address.dart';
import 'package:fruit_jus_168/features/address/domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressDataSource addressDataSource;

  AddressRepositoryImpl({required this.addressDataSource});

  @override
  Future<List<AddressEntity>> getAddresses() async {
    try {
      final List<AddressModel> addressesModel =
          await addressDataSource.getAddresses();
      return addressesModel;
    } catch (e) {
      // Handle the exception or throw it as needed
      throw Exception('Failed to get addresses: $e');
    }
  }

  @override
  Future<AddressEntity> getAddress(String addressId) async {
    try {
      final AddressModel addressesModel =
          await addressDataSource.getAddress(addressId);
      return addressesModel;
    } catch (e) {
      // Handle the exception or throw it as needed
      throw Exception('Failed to get addresses: $e');
    }
  }

  @override
  Future<void> addAddress(AddressEntity address) async {
    try {
      await addressDataSource.addAddress(AddressModel.fromEntity(address));
    } catch (e) {
      throw Exception('Failed to add address: $e');
    }
  }

  @override
  Future<void> editAddress(AddressEntity address) async {
    try {
      await addressDataSource.editAddress(AddressModel.fromEntity(address));
    } catch (e) {
      throw Exception('Failed to edit address: $e');
    }
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    try {
      await addressDataSource.deleteAddress(addressId);
    } catch (e) {
      throw Exception('Failed to delete address: $e');
    }
  }

  @override
  Future<void> updateDefaultAddress(String addressId) async {
    try {
      await addressDataSource.updateDefaultAddress(addressId);
    } catch (e) {
      throw Exception('Failed to update default address: $e');
    }
  }
}
