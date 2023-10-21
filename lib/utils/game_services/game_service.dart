import 'dart:convert';
import 'package:games_services/games_services.dart';

class GameService {
  Future<String?> signIn() async {
    try {
      final result = await GameAuth.signIn(shouldEnableSavedGame: true);

      return result;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<bool> isSignedIn() async {
    final result = await GameAuth.isSignedIn;
    return result;
  }

  Future<String?> signOut() async {
    final result = await GameAuth.signOut();
    return result;
  }

  Future<String?> getPlayerID() async {
    final result = await Player.getPlayerID();
    return result;
  }

  Future<String?> getPlayerName() async {
    final result = await Player.getPlayerName();
    return result;
  }

  Future<int?> getPlayerScore() async {
    final result = await Player.getPlayerScore();
    return result;
  }

  void showAccessPoint() async {
    await Player.showAccessPoint(AccessPointLocation.topLeading);
  }

  void hideAccessPoint() async {
    await Player.hideAccessPoint();
  }

  void incrementAchievement() async {
    await Achievements.increment(
        achievement: Achievement(androidID: 'android_id', steps: 50));
  }

  void unlockAchievement() async {
    await Achievements.unlock(
        achievement: Achievement(
            androidID: 'android_id', iOSID: 'ios_id', percentComplete: 100));
  }

  void loadAchievement() async {
    await Achievements.loadAchievements();
  }

  Future<List?> loadLeaderboardScores() async {
    final result = await Leaderboards.loadLeaderboardScores(
      androidLeaderboardID: "CgkIn9Txut0NEAIQAg",
      scope: PlayerScope.global,
      timeScope: TimeScope.allTime,
      maxResults: 10,
    );
    return result;
  }

  Future<String?> submitScore(int score) async {
    final result = await Leaderboards.submitScore(
      score: Score(
        androidLeaderboardID: 'CgkIn9Txut0NEAIQAg',
        value: score,
      ),
    );
    return result;
  }

  Future<String?> showLeaderboards() async {
    final result = await Leaderboards.showLeaderboards(
      androidLeaderboardID: 'CgkIn9Txut0NEAIQAg',
    );
    return result;
  }

  Future<String?> showAchievements() async {
    final result = await Achievements.showAchievements();
    return result;
  }

  Future<List<SavedGame>?> getSavedGames() async {
    final result = await SaveGame.getSavedGames();
    return result;
  }

  Future<String?> saveGame() async {
    final data = jsonEncode(GameData(96, "sword").toJson());
    final result = await SaveGame.saveGame(data: data, name: "slot1");
    return result;
  }

  Future<GameData?> loadGame() async {
    final result = await SaveGame.loadGame(name: "slot1");
    if (result != null) {
      final Map json = jsonDecode(result);
      final gameData = GameData.fromJson(json);
      print("Player progress ${gameData.progress}");
      print("Player weapon ${gameData.weapon}");
      return gameData;
    } else {
      return null;
    }
  }

  Future<String?> deleteGame() async {
    final result = await SaveGame.deleteGame(name: "slot1");
    return result;
  }
}

class GameData {
  int progress;
  String weapon;
  GameData(this.progress, this.weapon);

  factory GameData.fromJson(Map json) {
    return GameData(json["progress"], json["weapon"]);
  }

  Map toJson() => {'progress': progress, 'weapon': weapon};
}
