import 'package:fruit_jus_168/features/address/domain/repositories/address_repository.dart';

class UpdateDefaultAddressUseCase {
  final AddressRepository _addressRepository;

  UpdateDefaultAddressUseCase(this._addressRepository);

  Future<void> call(String addressId) async {
    return await _addressRepository.updateDefaultAddress(addressId);
  }
}
