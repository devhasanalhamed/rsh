import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timer/presentation/widgets/control_buttons.dart';
import 'package:timer/presentation/widgets/preset_buttons.dart';
// TODO: Redo responsive
// import 'package:timer/presentation/pages/responsive_layout.dart';
// import '../../data/models/timer_state.dart';
import 'package:timer/presentation/widgets/timer_display.dart';
import 'package:timer/presentation/widgets/timer_picker.dart';
import '../providers/timer_provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final timerState = ref.watch(timerProvider);
    final isDarkMode = ref.read(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('RSH', style: TextStyle(letterSpacing: 3.0)),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
          ),
        ],
      ),
      // body: ResponsiveLayout(
      //   mobile: _buildMobileLayout(timerState),
      //   tablet: _buildTabletLayout(timerState),
      //   desktop: _buildDesktopLayout(timerState),
      // ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!timerState.isInitial) TimerDisplay(state: timerState),
                    if (timerState.isInitial) ...[
                      const TimerPicker(),
                      const SizedBox(height: 20),
                      const PresetButtons(),
                      const SizedBox(height: 30),
                    ],
                  ],
                ),
              ),
            ),
            ControlButtons(state: timerState),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  //   Widget _buildMobileLayout(TimerState timerState) {
  //     return SingleChildScrollView(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         children: [
  //           const SizedBox(height: 20),
  //           TimerDisplay(state: timerState),
  //           const SizedBox(height: 30),
  //           if (timerState.isInitial) ...[
  //             const TimerPicker(),
  //             const SizedBox(height: 20),
  //             const PresetButtons(),
  //             const SizedBox(height: 30),
  //           ],
  //           ControlButtons(state: timerState),
  //         ],
  //       ),
  //     );
  //   }

  //   Widget _buildTabletLayout(TimerState timerState) {
  //     return Padding(
  //       padding: const EdgeInsets.all(24.0),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             flex: 2,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 TimerDisplay(state: timerState),
  //                 const SizedBox(height: 40),
  //                 ControlButtons(state: timerState),
  //               ],
  //             ),
  //           ),
  //           const SizedBox(width: 40),
  //           if (timerState.isInitial)
  //             Expanded(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   const TimerPicker(),
  //                   const SizedBox(height: 30),
  //                   const PresetButtons(),
  //                 ],
  //               ),
  //             ),
  //         ],
  //       ),
  //     );
  //   }

  //   Widget _buildDesktopLayout(TimerState timerState) {
  //     return Padding(
  //       padding: const EdgeInsets.all(32.0),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             flex: 3,
  //             child: Center(
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   TimerDisplay(state: timerState),
  //                   const SizedBox(height: 50),
  //                   ControlButtons(state: timerState),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           const SizedBox(width: 60),
  //           if (timerState.isInitial)
  //             Expanded(
  //               flex: 2,
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   const TimerPicker(),
  //                   const SizedBox(height: 40),
  //                   const PresetButtons(),
  //                 ],
  //               ),
  //             ),
  //         ],
  //       ),
  //     );
  //   }
}
