import 'package:fruit_jus_168/features/address/domain/entities/address.dart';
import 'package:fruit_jus_168/features/address/domain/repositories/address_repository.dart';

class GetAddressUseCase {
  final AddressRepository _addressRepository;

  GetAddressUseCase(this._addressRepository);

  Future<AddressEntity> call(String addressId) async {
    return await _addressRepository.getAddress(addressId);
  }
}
