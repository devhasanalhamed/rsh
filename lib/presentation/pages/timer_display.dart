import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/timer_state.dart';
import '../../core/utils/time_formatter.dart';
import '../../core/constants/app_colors.dart';

class TimerDisplay extends ConsumerWidget {
  final TimerState state;

  const TimerDisplay({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            if (state.duration.inSeconds > 0)
              Container(
                width: 200,
                height: 8,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: theme.colorScheme.surfaceContainerHighest,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: state.progress,
                    backgroundColor: theme.colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),

            Text(
              TimeFormatter.formatDuration(state.remaining),
              style: theme.textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: _getStatusColor(state.status).withOpacity(0.2),
              ),
              child: Text(
                _getStatusText(state.status),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: _getStatusColor(state.status),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(TimerStatus status) {
    switch (status) {
      case TimerStatus.initial:
        return AppColors.grey;
      case TimerStatus.running:
        return AppColors.secondaryLight;
      case TimerStatus.paused:
        return Colors.orange;
      case TimerStatus.completed:
        return AppColors.primaryLight;
    }
  }

  String _getStatusText(TimerStatus status) {
    switch (status) {
      case TimerStatus.initial:
        return 'Ready';
      case TimerStatus.running:
        return 'Running';
      case TimerStatus.paused:
        return 'Paused';
      case TimerStatus.completed:
        return 'Completed!';
    }
  }
}
