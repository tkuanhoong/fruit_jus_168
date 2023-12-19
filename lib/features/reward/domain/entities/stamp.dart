import 'package:equatable/equatable.dart';

class StampEntity extends Equatable {
  int stampCount = 0;

  // List<Object?> get props => [name];
  StampEntity({
    required this.stampCount,
  });

  @override
  List<Object?> get props {
    return [
      stampCount,
    ];
  }
}
