class CarouselModel {
  CarouselModel({required this.id, required this.image});

  final String id;
  final String image;

  CarouselModel.fromJson(Map<String, Object?> json)
      : this(id: json['Title']! as String, image: json['Image-Url']! as String);

  Map<String, Object?> toJson() {
    return {
      'Title': id,
      'Image-Url': image,
    };
  }
}
