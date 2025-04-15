import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:game_studio/main.dart';

class Bullet extends RectangleComponent with HasGameRef<SimpleGame>, CollisionCallbacks {
  late Vector2 velocity;

  final rng = Random();

  Bullet({
    required Vector2 startPosition,
  }) : super(
          position: startPosition,
          size: _generateRandomSize(),
          paint: Paint()..color = _generateColor(),
        );

  static Vector2 _generateRandomSize() {
    final rng = Random();
    final width = rng.nextInt(30) + 10; // entre 10 et 39
    final height = rng.nextInt(20) + 5; // entre 5 et 24
    return Vector2(width.toDouble(), height.toDouble());
  }

  static Color _generateColor() {
    final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
  ];

    final rng = Random();
    final index = rng.nextInt(5);
    return colors[index];
  }


  @override
  Future<void> onLoad() async {
    super.onLoad();
    anchor = Anchor.center;

    add(RectangleHitbox());

    // Génère une direction aléatoire
    final angle = rng.nextDouble() * 2 * pi;
    velocity = Vector2(cos(angle), sin(angle)) * 150; // vitesse de 150 px/s
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt;

    // Si le projectile sort de l'écran, on le retire
    final screenRect = gameRef.size.toRect();
    if (!screenRect.contains(Offset(position.x, position.y))) {
      removeFromParent();
    }
  }
}