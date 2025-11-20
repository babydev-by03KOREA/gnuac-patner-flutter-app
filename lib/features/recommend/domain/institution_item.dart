class InstitutionItem {
  final int id;
  final String name;
  final String imageUrl;

  InstitutionItem({
    required this.id,
    required this.name,
    required this.imageUrl
  });

  factory InstitutionItem.fromJson(Map<String, dynamic> json) {
    return InstitutionItem(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
