import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class IndexFailure extends Failure {}

class GenericFailure extends Failure { }