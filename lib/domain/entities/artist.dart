import 'package:equatable/equatable.dart';

class Artist extends Equatable {
  final String name;

  Artist(this.name);

  @override
  List<Object> get props => [name];
}
