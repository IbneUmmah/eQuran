import 'package:flutter/material.dart';

import 'package:quran/widgets/reuseablewidgets.dart';

class MyCustomAnimation extends StatefulWidget {
  final Duration duration;

  const MyCustomAnimation(
      {Key? key, this.duration = const Duration(seconds: 3)})
      : super(key: key);

  @override
  State<MyCustomAnimation> createState() => _MyCustomAnimationState();
}

class _MyCustomAnimationState extends State<MyCustomAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double value = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _controller.value = 1.0;
    _controller.reverse();
    _controller.addListener(() {
      setState(() {
        value = _controller.value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 23,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Continue Reading where your left off',
              textAlign: TextAlign.justify,
            ),
          ),
          LinearProgressIndicator(
            value: value,
            color: Colors.green,
          )
        ],
      ),
    );
  }
}

class CountDownAnimation extends StatefulWidget {
  final Duration duration;
  final Widget child;
  final Color color;
  const CountDownAnimation(
      {Key? key,
      required this.child,
      this.duration = const Duration(seconds: 4),
      this.color = Colors.green})
      : super(key: key);

  @override
  State<CountDownAnimation> createState() => _CountDownAnimationState();
}

class _CountDownAnimationState extends State<CountDownAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double value = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _controller.value = 1.0;
    _controller.reverse();
    _controller.addListener(() {
      setState(() {
        value = _controller.value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 23,
      child: Column(
        children: [
          widget.child,
          LinearProgressIndicator(
            value: value,
            color: widget.color,
          )
        ],
      ),
    );
  }
}

class AyahRecitingWidget extends StatefulWidget {
  final Duration? duration;
  final String text;
  final TextDirection textDirection;

  const AyahRecitingWidget(
      {Key? key,
      this.text = 'Ayah Reciting',
      this.duration,
      required this.textDirection})
      : super(key: key);

  @override
  State<AyahRecitingWidget> createState() => _AyahRecitingWidgetState();
}

class _AyahRecitingWidgetState extends State<AyahRecitingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double value = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        duration: widget.duration ?? const Duration(minutes: 1), vsync: this);
    _controller.value = 1.0;
    _controller.reverse();
    _controller.addListener(() {
      setState(() {
        value = _controller.value;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Align(
            alignment: widget.textDirection == TextDirection.ltr
                ? Alignment.topLeft
                : Alignment.topRight,
            child: MarqueeWidget(
              animationDuration: widget.duration ?? const Duration(minutes: 1),
              textDirection: widget.textDirection,
              child: Text(
                widget.text,
                textDirection: widget.textDirection,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          LinearProgressIndicator(
            value: widget.duration == null ? 1.0 : value,
            color: Colors.green,
            valueColor: widget.duration == null
                ? const AlwaysStoppedAnimation(Colors.yellow)
                : null,
          )
        ],
      ),
    );
  }
}
