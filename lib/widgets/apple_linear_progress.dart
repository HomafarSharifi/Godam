
import 'package:flutter/material.dart';

class AppleLinearProgress extends StatefulWidget {
  const AppleLinearProgress({
    super.key,
    this.height = 6,
    this.duration = const Duration(milliseconds: 5000),
    this.onCompleted,
    this.controller,
  });

  final double height;
  final Duration duration;
  final VoidCallback? onCompleted;
  final AppleLinearProgressController? controller;

  @override
  State<AppleLinearProgress> createState() =>
      _AppleLinearProgressState();
}

class AppleLinearProgressController {
  VoidCallback? _start;

  void start() => _start?.call();
}

class _AppleLinearProgressState extends State<AppleLinearProgress>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _animation;

  bool _completionReported = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener(_handleStatus);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    widget.controller?._start = start;
  }

  void start() {
    if (!_controller.isAnimating && !_controller.isCompleted) {
      _controller.forward();
    }
  }

  void _handleStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed || _completionReported) {
      return;
    }

    _completionReported = true;
    widget.onCompleted?.call();
  }

  @override
  void didUpdateWidget(covariant AppleLinearProgress oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._start = null;
      widget.controller?._start = start;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final reduceMotion =
        MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    if (reduceMotion && !_controller.isCompleted) {
      _controller.value = 1;
    }
  }

  @override
  void dispose() {
    widget.controller?._start = null;

    _animation.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color track = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withValues(alpha: 0.14)
        : Colors.black.withValues(alpha: 0.08);

    final Color fill = Theme.of(context).colorScheme.primary;

    return Semantics(
      label: 'Loading',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.height / 2),
        child: SizedBox(
          height: widget.height,
          width: double.infinity,
          child: ColoredBox(
            color: track,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) => Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: _animation.value,
                  child: ColoredBox(
                    color: fill,
                    child: child,
                  ),
                ),
              ),
              child: const SizedBox.expand(),
            ),
          ),
        ),
      ),
    );
  }
}
