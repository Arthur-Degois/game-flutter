import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class ScoreText extends TextComponent {
  int score = 0;

  ScoreText()
      : super(
          text: 'Score: 0',
          textRenderer: TextPaint(
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(10, 10); // en haut à gauche
    anchor = Anchor.topLeft;
  }

  void increase(int value) {
    score += value;
    text = 'Score: $score';
  }
}