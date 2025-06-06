import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer/core/enums/timer_status.dart';
import '../../data/models/timer_state.dart';
import '../../core/utils/time_formatter.dart';
import '../../core/constants/app_colors.dart';

class TimerDisplay extends ConsumerWidget {
  final TimerStateModel state;

  const TimerDisplay({super.key, required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Container(
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

            SizedBox(
              width: double.infinity,
              child: FittedBox(
                child: Text(TimeFormatter.formatDuration(state.remaining)),
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
                style: TextStyle(
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
