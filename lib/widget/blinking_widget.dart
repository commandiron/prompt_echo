import 'package:flutter/material.dart';


class BlinkingWidget extends StatefulWidget {
  const BlinkingWidget({super.key, required this.child});

   final Widget child;

  @override
  State<BlinkingWidget> createState() => _BlinkingWidgetState();
}

class _BlinkingWidgetState extends State<BlinkingWidget> with SingleTickerProviderStateMixin  {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 3 saniye boyunca 3 kez yanıp sönme: Her biri 1 saniye sürecek şekilde (fadeOut + fadeIn)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // her tur 1 saniye
    );

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // 3 tekrar yap (total 3 saniye)
    _startBlinking();
  }

  void _startBlinking() async {
    for (int i = 0; i < 3; i++) {
      await _controller.forward();
      await _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}
  