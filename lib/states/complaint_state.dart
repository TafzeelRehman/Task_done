// complaint_state.dart
import 'package:test_projects/model/complaint_model.dart';

abstract class ComplaintState {}

class ComplaintInitial extends ComplaintState {}

class ComplaintListUpdated extends ComplaintState {
  final List<ComplaintCardModel> complaints;

  ComplaintListUpdated(this.complaints);
}
