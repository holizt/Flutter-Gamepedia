import 'package:gamebot/model/model_game/cover_model.dart';
import 'package:gamebot/model/model_game/genre_model.dart';
import 'package:gamebot/model/model_game/screenshot_model.dart';

class GamesModel {
  int id;
  String name;
  String summary;
  String storyLine;
  double rating;
  CoverModel cover;
  List<GenreModel> genres;
  List<ScreenshotModel> screenshot;

  GamesModel(
      {this.id,
      this.name,
      this.cover,
      this.summary,
      this.rating,
      this.screenshot,
      this.genres,
      this.storyLine});

  factory GamesModel.fromJson(Map<String, dynamic> json) {
    return GamesModel(
      id: json['id'],
      name: json['name'],
      storyLine: json['storyline'],
      summary: json['summary'] == null ? null : json['summary'],
      cover: json['cover'] == null ? null : CoverModel.fromJson(json['cover']),
      screenshot: json['screenshots'] == null
          ? null
          : (json['screenshots'] as List)
              .map((i) => new ScreenshotModel.fromJson(i))
              .toList(),
      genres: json['genres'] == null
          ? null
          : (json['genres'] as List)
              .map((i) => new GenreModel.fromJson(i))
              .toList(),
      rating: json['total_rating'],
    );
  }
}
