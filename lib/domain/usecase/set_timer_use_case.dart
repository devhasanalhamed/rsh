import 'package:timer/core/exceptions/failure.dart';
import 'package:timer/core/usecase/base_use_case.dart';
import 'package:timer/domain/repository/base_timer_repository.dart';

class SetTimerUseCase extends VoidUseCase<NoParameters> {
  final BaseTimerRepository baseTimerRepository;

  SetTimerUseCase({required this.baseTimerRepository});

  @override
  Future<(Failure, void)> call(NoParameters parameters) async {
    return await baseTimerRepository.setTimer();
  }
}
