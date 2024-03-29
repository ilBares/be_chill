import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:be_chill/src/presentation/shared/bechill_painter.dart';

class PostRating extends StatefulWidget {
  const PostRating({
    super.key,
    required this.image,
    this.onLongPressStart,
    this.onLongPressEnd,
    this.onHorizontalDragStart,
  });

  final ImageProvider image;
  final void Function(LongPressStartDetails)? onLongPressStart;
  final void Function(LongPressEndDetails)? onLongPressEnd;
  final void Function(DragStartDetails)? onHorizontalDragStart;

  @override
  State<PostRating> createState() => _PostRatingState();
}

class _PostRatingState extends State<PostRating> {
  Offset? _tapPosition;
  Timer? _timer;
  Stopwatch? _stopwatch;
  double _rating = 0.0;

  @override
  void dispose() {
    _stopwatch?.stop();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _rating = 0.0;
    _stopwatch = Stopwatch()..start();

    const interval = Duration(milliseconds: 10);
    _timer = Timer.periodic(interval, (timer) {
      updateUI();
    });
  }

  void updateUI() {
    setState(() {
      _rating = min(1, _stopwatch!.elapsedMilliseconds / 2000.0);
    });
  }

  void _handleHorizontalDragStart(DragStartDetails details) {
    if (widget.onHorizontalDragStart != null) {
      widget.onHorizontalDragStart!(details);
    }
  }

  void _handleLongPressStart(LongPressStartDetails details) {
    if (widget.onLongPressStart != null) {
      widget.onLongPressStart!(details);
    }

    setState(() {
      _tapPosition = details.globalPosition;
    });
    _startTimer();
  }

  void _handleLongPressEnd(LongPressEndDetails details) {
    if (widget.onLongPressEnd != null) {
      widget.onLongPressEnd!(details);
    }

    setState(() {
      _stopwatch!.stop();
      _timer!.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    double dx = 0.0;
    double dy = 0.0;

    if (_tapPosition != null) {
      dx = (_tapPosition!.dx / MediaQuery.of(context).size.width - 0.5) * 2;
      dy = (_tapPosition!.dy / MediaQuery.of(context).size.height - 0.5) * 2;
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      // onHorizontalDragStart: _handleHorizontalDragStart,
      onLongPressStart: _handleLongPressStart,
      onLongPressEnd: _handleLongPressEnd,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.passthrough,
          children: [
            Image(
              fit: BoxFit.cover,
              image: widget.image,
            ),
            // LayoutBuilder(
            //   builder: (context, constraints) => CustomPaint(
            //     painter: DistanceColorPainter(_tapPosition, _rating),
            //     size: Size(
            //       constraints.maxWidth,
            //       constraints.maxHeight,
            //     ),
            //   ),
            // ),
            if (_tapPosition != null)
              Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: const [
                      Colors.transparent,
                      Colors.black87,
                    ],
                    center: Alignment(dx, dy),
                    radius: _rating * 2,
                  ),
                ),
              ),
            if (_tapPosition == null)
              Container(
                color: Colors.black87,
              ),
            if (_rating != 0.0)
              CustomPaint(
                painter: BeChillPainter(
                  rating: _rating,
                  center: _tapPosition,
                  fixedSize: const Size.fromRadius(50.0),
                ),
              )
          ],
        ),
      ),
    );
  }
}
