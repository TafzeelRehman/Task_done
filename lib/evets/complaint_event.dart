// complaint_event.dart
abstract class ComplaintEvent {}

class AddComplaint extends ComplaintEvent {
  final String username;
  final String description;
  final String status;
  final String category;
  final String date;
  final List<String> images;

  AddComplaint({
    required this.username,
    required this.description,
    required this.status,
    required this.category,
    required this.date,
    required this.images,
  });
}

class EditComplaint extends ComplaintEvent {
  final int index;
  final String username;
  final String description;
  final String status;
  final String category;

  EditComplaint({
    required this.index,
    required this.username,
    required this.description,
    required this.status,
    required this.category,
  });
}

class FilterComplaints extends ComplaintEvent {
  final String query;

  FilterComplaints(this.query);
}

class DeleteComplaint extends ComplaintEvent {
  final int index;

  DeleteComplaint({required this.index});
}
