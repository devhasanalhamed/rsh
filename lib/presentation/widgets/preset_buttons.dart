import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer/data/models/preset_timer.dart';
import 'package:timer/presentation/providers/preset_provider.dart';
import 'package:timer/presentation/providers/timer_provider.dart';

class PresetButtons extends ConsumerWidget {
  const PresetButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presets = ref.watch(presetProvider);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.start,
      children: presets.map((preset) {
        return _buildPresetChip(context, ref, preset);
      }).toList(),
    );
  }

  Widget _buildPresetChip(
    BuildContext context,
    WidgetRef ref,
    PresetTimerModel preset,
  ) {
    return GestureDetector(
      onLongPress: () => _showDeletePresetDialog(context, ref, preset),
      child: ActionChip(
        label: Text(
          preset.name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
        onPressed: () {
          ref.read(timerProvider.notifier).setTimer(preset.duration);
        },
      ),
    );
  }

  String _formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ${duration.inSeconds.remainder(60)}s';
    } else {
      return '${duration.inSeconds}s';
    }
  }

  void _showAddPresetDialog(BuildContext context, WidgetRef ref) {
    showDialog(context: context, builder: (context) => _AddPresetDialog());
  }

  void _showDeletePresetDialog(
    BuildContext context,
    WidgetRef ref,
    PresetTimerModel preset,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Preset'),
        content: Text('Are you sure you want to delete "${preset.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(presetProvider.notifier).removePreset(preset);
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _AddPresetDialog extends ConsumerStatefulWidget {
  @override
  ConsumerState<_AddPresetDialog> createState() => _AddPresetDialogState();
}

class _AddPresetDialogState extends ConsumerState<_AddPresetDialog> {
  final _nameController = TextEditingController();
  int _hours = 0;
  int _minutes = 5;
  int _seconds = 0;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Preset'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Preset Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildTimeInput('Hours', _hours, 23, (value) {
                  setState(() => _hours = value);
                }),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTimeInput('Minutes', _minutes, 59, (value) {
                  setState(() => _minutes = value);
                }),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTimeInput('Seconds', _seconds, 59, (value) {
                  setState(() => _seconds = value);
                }),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: _addPreset, child: const Text('Add')),
      ],
    );
  }

  Widget _buildTimeInput(
    String label,
    int value,
    int max,
    ValueChanged<int> onChanged,
  ) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12)),
        const SizedBox(height: 4),
        SizedBox(
          width: 60,
          child: TextFormField(
            initialValue: value.toString(),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            ),
            onChanged: (text) {
              final newValue = int.tryParse(text) ?? 0;
              if (newValue >= 0 && newValue <= max) {
                onChanged(newValue);
              }
            },
          ),
        ),
      ],
    );
  }

  void _addPreset() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a preset name')),
      );
      return;
    }

    final duration = Duration(
      hours: _hours,
      minutes: _minutes,
      seconds: _seconds,
    );
    if (duration.inSeconds == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please set a time greater than 0')),
      );
      return;
    }

    final preset = PresetTimerModel(
      name: name,
      hours: _hours,
      minutes: _minutes,
      seconds: _seconds,
    );

    ref.read(presetProvider.notifier).addPreset(preset);
    Navigator.of(context).pop();
  }
}
