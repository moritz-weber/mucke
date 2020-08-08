import 'package:equatable/equatable.dart';

class Artist extends Equatable {
  const Artist({this.name});

  final String name;

  @override
  List<Object> get props => [name];
}
