import 'package:fruit_jus_168/features/address/domain/entities/address.dart';
import 'package:fruit_jus_168/features/address/domain/repositories/address_repository.dart';

class GetAddressesUseCase {
  final AddressRepository _addressRepository;

  GetAddressesUseCase(this._addressRepository);

  Future<List<AddressEntity>> call() async {
    return await _addressRepository.getAddresses();
  }
}
