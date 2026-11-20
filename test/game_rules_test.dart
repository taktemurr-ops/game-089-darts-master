import 'package:flutter_test/flutter_test.dart';
import 'package:game_089_darts_master/core/arcade.dart';
import 'package:game_089_darts_master/core/level_plan.dart';
import 'package:game_089_darts_master/game/rules.dart';
import 'package:game_089_darts_master/game/shot_engine.dart';

void main() {
  final rules = DartsRules();
  final planner = LevelPlanner(gameId: rules.gameId, optionalMechanics: rules.optionalMechanics);

  ShotSim fresh([int n = 1]) => ShotSim(rules.build(planner.spec(n)).puzzle);

  test('drag and release fires a shot, a tiny tap does not', () {
    final s = fresh();
    if (s.usesReticle) {
      s.tick(const ArcadeInput(down: true, x: 500, y: 650));
      s.tick(const ArcadeInput(down: false, x: 500, y: 650));
      expect(s.shots, 0, reason: 'too short a hold');
      for (var i = 0; i < 10; i++) {
        s.tick(const ArcadeInput(down: true, x: 500, y: 650));
      }
      s.tick(const ArcadeInput(down: false, x: 500, y: 650));
      expect(s.shots, 1);
    } else {
      s.tick(const ArcadeInput(down: true, x: 500, y: 800));
      s.tick(const ArcadeInput(down: true, x: 503, y: 805));
      s.tick(const ArcadeInput(down: false, x: 503, y: 805));
      expect(s.shots, 0, reason: 'too short a drag');
      s.tick(const ArcadeInput(down: true, x: 500, y: 800));
      s.tick(const ArcadeInput(down: true, x: 500, y: 1000));
      s.tick(const ArcadeInput(down: false, x: 500, y: 1000));
      expect(s.shots, 1);
      expect(s.phase, 1);
    }
  });

  test('failing a round costs a life and restarts the same layout', () {
    final s = fresh(3);
    final before = s.goalText;
    s.roundFailed();
    expect(s.lives, 2);
    expect(s.goalText, before);
    expect(s.over, isFalse);
  });

  test('autopilot clears the first ten levels without losing a life', () {
    for (var n = 1; n <= 10; n++) {
      final s = fresh(n);
      final r = runBot(s, rules.bot, 60 * 60 * 6);
      expect(r.won, isTrue, reason: 'level $n');
      expect(s.stars, greaterThanOrEqualTo(1));
    }
  });

  test('darts: board scores and busts', () {
    final t20 = DartsSim.aimPoint(20, 3);
    expect(DartsSim.scoreAt(t20.$1, t20.$2).$1, 60);
    final d16 = DartsSim.aimPoint(16, 2);
    expect(DartsSim.scoreAt(d16.$1, d16.$2), (32, 2));
    expect(DartsSim.scoreAt(DartsSim.cx, DartsSim.cy).$1, 50);
    expect(DartsSim.scoreAt(DartsSim.cx, DartsSim.cy - 20).$1, 25);
    final s = fresh() as DartsSim;
    s.remaining = 10;
    s.turnStart = 10;
    final p = DartsSim.aimPoint(20, 1);
    s.land(p.$1, p.$2);
    expect(s.remaining, 10, reason: 'bust restores the score');
  });
}
