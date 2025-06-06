import 'package:timer/core/exceptions/failure.dart';

abstract class BaseTimerRepository {
  Future<(Failure, void)> setTimer();

  Future<(Failure, void)> startTimer();

  Future<(Failure, void)> pauseTimer();

  Future<(Failure, void)> resetTimer();
}
