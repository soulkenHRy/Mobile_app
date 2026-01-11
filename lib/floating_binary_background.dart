import 'dart:math';
import 'package:flutter/material.dart';

class FloatingBinaryBackground extends StatefulWidget {
  const FloatingBinaryBackground({super.key});

  @override
  State<FloatingBinaryBackground> createState() =>
      _FloatingBinaryBackgroundState();
}

class _FloatingBinaryBackgroundState extends State<FloatingBinaryBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<_BinaryParticle> _particles;
  final int _particleCount = 30;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    _particles = List.generate(_particleCount, (i) => _BinaryParticle.random());
    _controller.addListener(() {
      setState(() {
        for (var p in _particles) {
          p.update();
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _BinaryPainter(_particles), child: Container());
  }
}

class _BinaryParticle {
  double x;
  double y;
  double speed;
  double size;
  String value;
  Color color;
  static final Random _rnd = Random();

  _BinaryParticle(
    this.x,
    this.y,
    this.speed,
    this.size,
    this.value,
    this.color,
  );

  factory _BinaryParticle.random() {
    return _BinaryParticle(
      _rnd.nextDouble(),
      _rnd.nextDouble(),
      0.003 + _rnd.nextDouble() * 0.007,
      18 + _rnd.nextDouble() * 10,
      _rnd.nextBool() ? '0' : '1',
      Colors.greenAccent.withOpacity(0.7 + _rnd.nextDouble() * 0.3),
    );
  }

  void update() {
    y += speed;
    if (y > 1.0) {
      y = 0.0;
      x = _rnd.nextDouble();
      value = _rnd.nextBool() ? '0' : '1';
      size = 18 + _rnd.nextDouble() * 10;
      color = Colors.greenAccent.withOpacity(0.7 + _rnd.nextDouble() * 0.3);
    }
  }
}

class _BinaryPainter extends CustomPainter {
  final List<_BinaryParticle> particles;
  _BinaryPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      final offset = Offset(p.x * size.width, p.y * size.height);
      final textPainter = TextPainter(
        text: TextSpan(
          text: p.value,
          style: TextStyle(
            color: p.color,
            fontSize: p.size,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(blurRadius: 6, color: Colors.green, offset: Offset(0, 0)),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
