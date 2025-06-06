import 'package:timer/core/exceptions/failure.dart';
import 'package:equatable/equatable.dart';

abstract class BaseUseCase<T, Parameters> {
  Future<(Failure, T)> call(Parameters parameters);
}

abstract class VoidUseCase<Parameters> {
  Future<(Failure, void)> call(Parameters parameters);
}

class NoParameters extends Equatable {
  const NoParameters();

  @override
  List<Object?> get props => [];
}
