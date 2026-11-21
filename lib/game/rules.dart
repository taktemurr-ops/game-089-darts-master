import 'package:studio_core/core/arcade.dart';
import 'package:studio_core/core/level_plan.dart';
import 'package:studio_core/core/missions.dart';
import 'package:studio_core/core/stats.dart';
import 'shot_engine.dart';

class DartsRules extends ArcadeRules<ShotLevel> {
  @override
  String get gameId => 'game-089-darts-master';

  @override
  List<String> get optionalMechanics => const [];

  @override
  List<GameStat> get gameStats => const [
        GameStat('darts_thrown', 'Atılan dart', 'Darts thrown', scale: 600),
        GameStat('legs_won', 'Kazanılan leg', 'Legs won', scale: 40),
        GameStat('triples', 'Triple isabet', 'Triples', scale: 150),
        GameStat('bullseyes', 'Tam merkez', 'Bullseyes', scale: 50),
      ];

  @override
  List<MissionTemplate> get missionTemplates => const [
        MissionTemplate('darts_thrown', 'darts_thrown', [150, 300, 600]),
        MissionTemplate('legs_won', 'legs_won', [5, 10, 20], coinReward: 80),
      ];

  @override
  ShotLevel generate(LevelSpec spec) => generateShot(ShotKind.darts, spec);

  @override
  ArcadeMeta metaOf(ShotLevel l) => l.meta;

  @override
  ArcadeSim createSim(ShotLevel l) => ShotSim(l);

  @override
  ArcadeInput bot(ArcadeSim sim) => shotBot(sim);
}

ArcadeRules createRules() => DartsRules();
