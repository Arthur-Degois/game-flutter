import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:game_studio/component/bullet.dart';

class Player extends CircleComponent with CollisionCallbacks {
  late Timer colorTimer;

  final List<Color> colors;
  int currentColorIndex = 0;

  Player({required this.colors})
      : super(
          radius: 10,
          paint: Paint()..color = colors.first,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();

    colorTimer = Timer(5, onTick: () {
      currentColorIndex += 1;
      if (currentColorIndex >= colors.length) {
        currentColorIndex = 0;
      }
      paint.color = colors[currentColorIndex];
    }, repeat: true);

    add(CircleHitbox());
    colorTimer.start();

    // Centrer l'ancrage pour que le placement et les collisions soient précis
    anchor = Anchor.center;
  }

  void nextColor() {
    currentColorIndex = (currentColorIndex + 1) % colors.length;
    paint.color = colors[currentColorIndex];
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Bullet) {
      if (other.paint.color == paint.color) {
        print("+1 point");
      } else {
        print("💥 Le joueur a été touché !");
      }
      other.removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }



   @override
  void update(double dt) {
    super.update(dt);

    colorTimer.update(dt);

  }

}