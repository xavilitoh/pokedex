

import 'package:flutter/material.dart';

class AnimatedBall extends StatefulWidget {

  const AnimatedBall({
    super.key,
    this.imageHeight,
    this.opacity = 1,
    this.color = Colors.white38,
    required this.controller
  });

  final double opacity;
  final double? imageHeight;
  final Color? color;
  final AnimationController controller;

  @override
  State<AnimatedBall> createState() => _AnimatedBallState();
}

class _AnimatedBallState extends State<AnimatedBall>  {


  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(widget.controller),
      child: Image.asset(
        'assets/images/pokeball.png', 
        height: widget.imageHeight, 
        fit: BoxFit.fill,
        alignment: Alignment.center,
        color: widget.color,
      ),
    );
  }
}