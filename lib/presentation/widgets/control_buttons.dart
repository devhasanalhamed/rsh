import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/timer_provider.dart';
import '../../data/models/timer_state.dart';

class ControlButtons extends ConsumerWidget {
  final TimerStateModel state;

  const ControlButtons({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (state.isInitial)
          _buildStartButton(ref)
        else if (state.isRunning) ...[
          _buildPauseButton(ref),
          const SizedBox(width: 16.0),
          _buildResetButton(ref),
        ] else if (state.isPaused)
          _buildResumeButton(ref)
        else if (state.isCompleted)
          _buildResetButton(ref),
      ],
    );
  }

  Widget _buildStartButton(WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: state.remaining.inSeconds > 0
          ? () => ref.read(timerProvider.notifier).startTimer()
          : null,
      icon: const Icon(Icons.play_arrow),
      label: const Text('Start'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }

  Widget _buildPauseButton(WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () => ref.read(timerProvider.notifier).pauseTimer(),
      icon: const Icon(Icons.pause),
      label: const Text('Pause'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }

  Widget _buildResumeButton(WidgetRef ref) {
    return ElevatedButton.icon(
      onPressed: () => ref.read(timerProvider.notifier).startTimer(),
      icon: const Icon(Icons.play_arrow),
      label: const Text('Resume'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }

  Widget _buildResetButton(WidgetRef ref) {
    return OutlinedButton.icon(
      onPressed: () => ref.read(timerProvider.notifier).resetTimer(),
      icon: const Icon(Icons.refresh),
      label: const Text('Reset'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }
}
