class CoverModel {
  int id;
  int height;
  int width;
  String imageId;
  String url;

  CoverModel({this.id, this.height, this.width, this.imageId, this.url});

  factory CoverModel.fromJson(Map<String, dynamic> json) {
    return CoverModel(
      id: json['id'],
      height: json['height'],
      width: json['width'],
      imageId: json['image_id'],
      url: json['url'],
    );
  }
}
