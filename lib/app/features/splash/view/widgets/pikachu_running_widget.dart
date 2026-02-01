import 'dart:async' as dart_async;
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

class PikachuRunningWidget extends StatefulWidget {
  const PikachuRunningWidget({super.key});

  @override
  State<PikachuRunningWidget> createState() => _PikachuRunningWidgetState();
}

class _PikachuRunningWidgetState extends State<PikachuRunningWidget> {
  Future<SpriteAnimation>? _animationFuture;

  final List<String> _phrases = [
    'Travando nos Arbustos...',
    'Registrando na Pokédex...',
    'Aqui não tem Team Rocket...ainda',
    'Lutando com o Mewtwo...',
    'O Ash perdeu o torneio...denovo',
    'Aguarde, um ditto passou pelo backend...',
    'Magikarp não aprende Hydro Pump...',
    'Temos que pegar!',
  ];

  int _currentPhraseIndex = 0;
  dart_async.Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animationFuture = _loadAnimation();

    _timer = dart_async.Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentPhraseIndex = (_currentPhraseIndex + 1) % _phrases.length;
      });
    });
  }

  @override
  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  Future<SpriteAnimation> _loadAnimation() async {
    final spriteSheet = await Flame.images.load('pikachu_running_sprite.png');
    final spriteAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 3,
        stepTime: 0.1,
        textureSize: Vector2(34, 30),
        texturePosition: Vector2(1, 0),
      ),
    );

    return spriteAnimation;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<SpriteAnimation>(
        future: _animationFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: SpriteAnimationWidget(
                  animation: snapshot.data!,
                  animationTicker: snapshot.data!.createTicker(),
                  anchor: Anchor.center,
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 100),
                child: Text(
                  _phrases[_currentPhraseIndex],
                  key: ValueKey(_phrases[_currentPhraseIndex]),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
