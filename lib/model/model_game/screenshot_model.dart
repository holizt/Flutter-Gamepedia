class ScreenshotModel {
  int id;
  String url;
  String imageId;

  ScreenshotModel({this.id, this.url, this.imageId});

  factory ScreenshotModel.fromJson(Map<String, dynamic> json) {
    return ScreenshotModel(
      id: json['id'],
      url: json['url'],
      imageId: json['image_id'],
    );
  }
}
