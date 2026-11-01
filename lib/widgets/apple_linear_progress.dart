import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AppleLinearProgress extends StatefulWidget {
  const AppleLinearProgress({super.key, this.height = 6});

  final double height;

  @override
  State<AppleLinearProgress> createState() => _AppleLinearProgressState();
}

class _AppleLinearProgressState extends State<AppleLinearProgress> {
  static const Cubic _ease = Cubic(0.22, 0.61, 0.36, 1);

  final Random _rng = Random();
  Timer? _timer;
  double _value = 0.0;

  @override
  void initState() {
    super.initState();
    _queue();
  }

  void _queue() {
    _timer?.cancel();
    if (_value >= 1.0) {
      _timer = Timer(const Duration(milliseconds: 1400), () {
        if (!mounted) return;
        setState(() => _value = 0.0);
        _timer = Timer(const Duration(milliseconds: 550), _queue);
      });
    } else {
      _timer = Timer(Duration(milliseconds: 280 + _rng.nextInt(441)), () {
        if (!mounted) return;
        setState(
          () => _value = min(1.0, _value + 0.05 + _rng.nextDouble() * 0.11),
        );
        _queue();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color track = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withOpacity(0.14)
        : Colors.black.withOpacity(0.08);
    final Color fill = Theme.of(context).colorScheme.primary;

    final bool reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;
    final Duration duration = reduceMotion
        ? Duration.zero
        : const Duration(milliseconds: 450);

    return Semantics(
      label: 'Loading',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.height / 2),
        child: Container(
          height: widget.height,
          width: double.infinity,
          color: track,
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedFractionallySizedBox(
              widthFactor: _value,
              duration: duration,
              curve: _ease,
              child: Container(color: fill),
            ),
          ),
        ),
      ),
    );
  }
}
