import 'package:equatable/equatable.dart';

class BeverageEntity extends Equatable {
  final String name;


  const BeverageEntity({required this.name});

  @override
  List<Object?> get props => [name];
}
