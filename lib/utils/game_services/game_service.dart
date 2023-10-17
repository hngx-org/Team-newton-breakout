import 'dart:convert';

import 'package:games_services/games_services.dart';

class GameService {
  Future<String?> signIn() async {
    try {
      final result = await GameAuth.signIn(shouldEnableSavedGame: true);
      print(result);
      return result;
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<bool> isSignedIn() async {
    final result = await GameAuth.isSignedIn;
    print(result);
    return result;
  }

  Future<String?> signOut() async {
    final result = await GameAuth.signOut();
    print(result);
    return result;
  }

  Future<String?> getPlayerID() async {
    final result = await Player.getPlayerID();
    print(result);
    return result;
  }

  Future<String?> getPlayerName() async {
    final result = await Player.getPlayerName();
    print(result);
    return result;
  }

  Future<int?> getPlayerScore() async {
    final result = await Player.getPlayerScore();
    print(result);
    return result;
  }

  void showAccessPoint() async {
    final result = await Player.showAccessPoint(AccessPointLocation.topLeading);
    print(result);
  }

  void hideAccessPoint() async {
    final result = await Player.hideAccessPoint();
    print(result);
  }

  void incrementAchievement() async {
    final result = await Achievements.increment(
        achievement: Achievement(androidID: 'android_id', steps: 50));
    print(result);
  }

  void unlockAchievement() async {
    final result = await Achievements.unlock(
        achievement: Achievement(
            androidID: 'android_id', iOSID: 'ios_id', percentComplete: 100));
    print(result);
  }

  void loadAchievement() async {
    final result = await Achievements.loadAchievements();
    print(result);
  }

  Future<List?> loadLeaderboardScores() async {
    final result = await Leaderboards.loadLeaderboardScores(
        iOSLeaderboardID: "ios_leaderboard_id",
        androidLeaderboardID: "android_leaderboard_id",
        scope: PlayerScope.global,
        timeScope: TimeScope.allTime,
        maxResults: 10);
    print(result);
    return result;
  }

  Future<String?> submitScore() async {
    final result = await Leaderboards.submitScore(
        score: Score(
            androidLeaderboardID: 'android_leaderboard_id',
            iOSLeaderboardID: 'ios_leaderboard_id',
            value: 5));
    print(result);
    return result;
  }

  Future<String?> showLeaderboards() async {
    final result = await Leaderboards.showLeaderboards(
        iOSLeaderboardID: 'ios_leaderboard_id');
    print(result);
    return result;
  }

  Future<String?> showAchievements() async {
    final result = await Achievements.showAchievements();
    print(result);
    return result;
  }

  Future<List<SavedGame>?> getSavedGames() async {
    final result = await SaveGame.getSavedGames();
    print(result);
    return result;
  }

  Future<String?> saveGame() async {
    final data = jsonEncode(GameData(96, "sword").toJson());
    final result = await SaveGame.saveGame(data: data, name: "slot1");
    print(result);
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
    print(result);
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
