import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_studio/component/bullet.dart';
import 'package:game_studio/component/player.dart';

void main() {
  runApp(GameWidget(game: SimpleGame()));
}

class SimpleGame extends FlameGame with KeyboardEvents, HasCollisionDetection {
  late final Player player;
  late Timer colorTimer;
  late Timer bulletTimer;

  final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
  ];

  int currentColorIndex = 0;

  final Set<LogicalKeyboardKey> keysPressed = {};

  final double speed = 200; // pixels par seconde

  @override
  Future<void> onLoad() async {
    player = Player(colors: colors);
    add(player);
    bulletTimer = Timer(0.5, onTick: () {
      final bullet = Bullet(startPosition: size / 2);
      add(bullet);
    }, repeat: true);
    bulletTimer.start();

      // Crée un projectile au centre de l'écran
    final bullet = Bullet(startPosition: size / 2);
    add(bullet);
  }

  @override
  void onMount() {
    super.onMount();
    _centerPlayer();
  }

  void _centerPlayer() {
    player.position = size / 2 - player.size / 2;
  }

  void move(double dt) {
    Vector2 delta = Vector2.zero();

    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      delta.y -= speed * dt;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      delta.y += speed * dt;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      delta.x -= speed * dt;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      delta.x += speed * dt;
    }

    player.position.add(delta);
  }

  @override
  void update(double dt) {
    super.update(dt);

    move(dt);
    
    // Empêcher de sortir de l'écran
    player.position.clamp(
      Vector2.zero(),
      size - player.size,
    );

    bulletTimer.update(dt);
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    this.keysPressed
      ..clear()
      ..addAll(keysPressed);
    return KeyEventResult.handled;
  }
}