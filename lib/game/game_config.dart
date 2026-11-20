import 'package:flutter/material.dart';

import '../app/arcade_stage.dart';
import '../app/game_api.dart';
import '../core/game_rules.dart';
import 'shot_engine.dart';
import 'shot_view.dart';
import 'rules.dart';

final gameConfig = GameConfig(
  gameId: 'game-089-darts-master',
  title: const ['Dart Ustası', 'Darts Master', 'Darts-Meister', 'Maestro de Dardos', 'Maître des Fléchettes'],
  tagline: const ['Triple 20, double ile bitiş!', 'Treble 20 and check out on a double!', 'Triple 20 und Doppel-Finish!', '¡Triple 20 y cierre doble!', 'Triple 20 et finish double !'],
  seedColor: const Color(0xFFD62828),
  icon: Icons.adjust,
  rules: DartsRules(),
  buildPlay: (ctx) => ArcadeStage(
    ctx: ctx,
    create: () => ShotSim((ctx.generated as GeneratedLevel<ShotLevel>).puzzle),
    paint: paintShot,
    sound: shotSound,
    boosterIcon: Icons.add_circle,
    boosterLabel: (l) => l == 'tr' ? '+3 dart' : '+3 darts',
    howTo: const ['Basılı tut, nişangahı hedefe getir; nişangah titrer. Parmağını kaldırınca atış yapılır. Uzun beklersen titreme artar.', 'Hold to aim – the sight sways. Lift your finger to shoot. Holding too long makes it shake more.', 'Halten zum Zielen, loslassen zum Schießen.', 'Mantén para apuntar, suelta para disparar.', 'Maintenez pour viser, relâchez pour tirer.'],
  ),
  tutorial: const [
    TutorialStep(Icons.gps_fixed, ['Basılı tut, nişan al, bırak.', 'Hold, aim, release.', 'Halten, zielen, loslassen.', 'Mantén, apunta, suelta.', 'Maintenez, visez, relâchez.']),
    TutorialStep(Icons.looks_3, ['Dış halka double, iç halka triple sayılır.', 'Outer ring = double, inner ring = treble.', 'Außen doppelt, innen dreifach.', 'Anillo exterior doble, interior triple.', 'Anneau extérieur double, intérieur triple.']),
    TutorialStep(Icons.block, ['Sıfırın altına inersen el bust olur.', 'Going below zero is a bust.', 'Unter Null = Bust.', 'Bajo cero = bust.', 'Sous zéro = bust.']),
  ],
);
