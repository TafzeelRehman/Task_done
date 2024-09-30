// complaint_card_model.dart
class ComplaintCardModel {
  final String username;
  final String description;
  final String status;
  final String category;
  final String date;
  final List<String> images;

  ComplaintCardModel({
    required this.username,
    required this.description,
    required this.status,
    required this.category,
    required this.date,
    required this.images,
  });

  ComplaintCardModel copyWith({
    String? username,
    String? description,
    String? status,
    String? category,
    String? date,
    List<String>? images,
  }) {
    return ComplaintCardModel(
      username: username ?? this.username,
      description: description ?? this.description,
      status: status ?? this.status,
      category: category ?? this.category,
      date: date ?? this.date,
      images: images ?? this.images,
    );
  }
}
