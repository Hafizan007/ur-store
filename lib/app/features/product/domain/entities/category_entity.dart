import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String name;

  const CategoryEntity({
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}
