import 'package:fruit_jus_168/features/address/domain/repositories/address_repository.dart';

class DeleteAddressUseCase {
  final AddressRepository _addressRepository;

  DeleteAddressUseCase(this._addressRepository);

  Future<void> call(String addressId) async {
    return await _addressRepository.deleteAddress(addressId);
  }
}
