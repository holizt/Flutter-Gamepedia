import 'package:gamebot/model/games_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RepositoryGames {
  static String mainUrl = 'https://api.igdb.com/v4';
  var gameListUrl = '$mainUrl/games';
  final String _apikey = 'zs3qbidjqua62tek0fclrj4043p85h';
  final String _accesToken = 'twfb1d7s2ugf5xiz1pit00qits5bjd';
  final String _fieldSlider =
      'fields age_ratings,category,cover.*,created_at,first_release_date,game_modes,genres.*,keywords,name,platforms,rating,rating_count,release_dates,screenshots.*,status,storyline,summary,tags,themes,total_rating,total_rating_count,updated_at,url,version_parent,version_title,videos,websites; where release_dates.platform = (6); limit 100;';
  final String _fieldGamesPopular =
      'fields age_ratings,category,cover.*,created_at,first_release_date,game_modes,genres.*,keywords,name,platforms,rating,rating_count,release_dates,screenshots.*,status,storyline,summary,tags,themes,total_rating,total_rating_count,updated_at,url,version_parent,version_title,videos,websites; where release_dates.platform = (6) & cover.image_id != null & genres.* != null & videos.* != null & created_at > 1252214987 & rating > 80; limit 100; sort popularity desc;"';

  Future<List<GamesModel>> getGameSlider() async {
    List<GamesModel> games = List();
    await http
        .post(
      gameListUrl,
      headers: {
        'Client-ID': '$_apikey',
        'Authorization': 'Bearer $_accesToken',
        'Accept': 'application/json'
      },
      body: _fieldSlider,
    )
        .then((response) {
      Iterable it = json.decode(response.body);
      games = it.map((e) => GamesModel.fromJson(e)).toList();
    });
    return games;
  }

  Future<List<GamesModel>> getGamesPopular() async {
    List<GamesModel> games = List();
    await http
        .post(
      gameListUrl,
      headers: {
        'Client-ID': '$_apikey',
        'Authorization': 'Bearer $_accesToken',
        'Accept': 'application/json'
      },
      body: _fieldGamesPopular,
    )
        .then((response) {
      Iterable it = json.decode(response.body);
      games = it.map((e) => GamesModel.fromJson(e)).toList();
    });
    return games;
  }
}
