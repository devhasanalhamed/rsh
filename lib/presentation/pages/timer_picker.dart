import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/timer_provider.dart';
import '../../core/constants/app_constants.dart';

class TimerPicker extends ConsumerStatefulWidget {
  const TimerPicker({super.key});

  @override
  ConsumerState<TimerPicker> createState() => _TimerPickerState();
}

class _TimerPickerState extends ConsumerState<TimerPicker> {
  int _hours = 0;
  int _minutes = 5;
  int _seconds = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Set Timer', style: theme.textTheme.headlineMedium),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimePicker(
                  label: 'Hours',
                  value: _hours,
                  max: AppConstants.maxTimerHours,
                  onChanged: (value) => setState(() => _hours = value),
                ),
                _buildTimePicker(
                  label: 'Minutes',
                  value: _minutes,
                  max: AppConstants.maxTimerMinutes,
                  onChanged: (value) => setState(() => _minutes = value),
                ),
                _buildTimePicker(
                  label: 'Seconds',
                  value: _seconds,
                  max: AppConstants.maxTimerSeconds,
                  onChanged: (value) => setState(() => _seconds = value),
                ),
              ],
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _setTimer,
                child: const Text('Set Timer'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker({
    required String label,
    required int value,
    required int max,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 40,
            perspective: 0.005,
            diameterRatio: 1.2,
            physics: const FixedExtentScrollPhysics(),
            controller: FixedExtentScrollController(initialItem: value),
            onSelectedItemChanged: onChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: max + 1,
              builder: (context, index) {
                return Center(
                  child: Text(
                    index.toString().padLeft(2, '0'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: index == value
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: index == value
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _setTimer() {
    final duration = Duration(
      hours: _hours,
      minutes: _minutes,
      seconds: _seconds,
    );

    if (duration.inSeconds > 0) {
      ref.read(timerProvider.notifier).setTimer(duration);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please set a time greater than 0')),
      );
    }
  }
}
