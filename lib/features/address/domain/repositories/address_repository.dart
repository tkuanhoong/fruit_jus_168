import 'package:fruit_jus_168/features/address/domain/entities/address.dart';

abstract class AddressRepository {
  Future<List<AddressEntity>> getAddresses();

  Future<AddressEntity> getAddress(String addressId);

  Future<void> addAddress(AddressEntity address);

  Future<void> editAddress(AddressEntity address);

  Future<void> deleteAddress(String addressId);

  Future<void> updateDefaultAddress(String addressId);
}
