import 'package:fruit_jus_168/features/address/domain/entities/address.dart';
import 'package:fruit_jus_168/features/address/domain/repositories/address_repository.dart';

class AddAddressUseCase {
  final AddressRepository _addressRepository;

  AddAddressUseCase(this._addressRepository);

  Future<void> call(AddressEntity address) async {
    return await _addressRepository.addAddress(address);
  }
}
