class SnackItem {
  final int id;
  final String title;
  final String imageUrl;

  SnackItem({
    required this.id,
    required this.title,
    required this.imageUrl
  });

  factory SnackItem.fromJson(Map<String, dynamic> json) {
    return SnackItem(
      id: json['id'] as int,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String
    );
  }
}
