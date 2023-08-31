import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wow_shopping/features/connection_monitor/provider/connected_state_notifier.dart';
import 'package:wow_shopping/widgets/common.dart';

@immutable
class ConnectionMonitor extends ConsumerWidget {
  const ConnectionMonitor({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final result = snapshot.requireData;
    final result = ref.watch(connectedStateNotifierProvider);
    if (result == MyNetworkStatus.OffNetork) {
      return Stack(
        children: [
          child,
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              alignment: Alignment.topCenter,
              child: Align(
                alignment: Alignment.topCenter,
                heightFactor: result != MyNetworkStatus.OffNetork ? 0.0 : 1.0,
                child: Material(
                  color: Colors.red,
                  child: Padding(
                    padding: verticalPadding4 + horizontalPadding12,
                    child: const Text(
                      'Please check your internet connection',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return child;
    }
  }
}
