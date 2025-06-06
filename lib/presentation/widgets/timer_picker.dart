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
  int _minutes = 0;
  int _seconds = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 260,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTimePicker(
                    value: _hours,
                    max: AppConstants.maxTimerHours,
                    onChanged: (value) => setState(() {
                      _hours = value;
                      _setTimer();
                    }),
                  ),
                  _buildColonSeparator(),
                  _buildTimePicker(
                    value: _minutes,
                    max: AppConstants.maxTimerMinutes,
                    onChanged: (value) => setState(() {
                      _minutes = value;
                      _setTimer();
                    }),
                  ),
                  _buildColonSeparator(),

                  _buildTimePicker(
                    value: _seconds,
                    max: AppConstants.maxTimerSeconds,
                    onChanged: (value) => setState(() {
                      _seconds = value;
                      _setTimer();
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildColonSeparator() =>
      SizedBox(height: 60, child: FittedBox(child: Text(':')));

  Widget _buildTimePicker({
    required int value,
    required int max,
    required ValueChanged<int> onChanged,
  }) {
    final values = List.generate(max, (index) => index);

    return Flexible(
      child: ListWheelScrollView.useDelegate(
        itemExtent: 60,
        perspective: 0.003,
        diameterRatio: 1.2,
        physics: const FixedExtentScrollPhysics(),
        controller: FixedExtentScrollController(initialItem: value),

        onSelectedItemChanged: (v) {
          onChanged(v);
        },
        childDelegate: ListWheelChildLoopingListDelegate(
          children: values.map((e) {
            final isHighlited = e == value;
            return FittedBox(
              child: Text(
                e.toString().padLeft(2, '0'),
                style: TextStyle(
                  color: isHighlited
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _setTimer() {
    final duration = Duration(
      hours: _hours,
      minutes: _minutes,
      seconds: _seconds,
    );

    ref.read(timerProvider.notifier).setTimer(duration);
  }
}
