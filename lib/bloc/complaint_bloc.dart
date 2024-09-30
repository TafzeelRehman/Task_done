// complaint_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_projects/evets/complaint_event.dart';
import 'package:test_projects/model/complaint_model.dart';
import 'package:test_projects/states/complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  List<ComplaintCardModel> complaints = [];

  ComplaintBloc() : super(ComplaintInitial());

  Stream<ComplaintState> mapEventToState(ComplaintEvent event) async* {
    if (event is AddComplaint) {
      complaints.add(ComplaintCardModel(
        username: event.username,
        description: event.description,
        status: event.status,
        category: event.category,
        date: event.date,
        images: event.images,
      ));
      yield ComplaintListUpdated(complaints);
    } else if (event is EditComplaint) {
      complaints[event.index] = complaints[event.index].copyWith(
        username: event.username,
        description: event.description,
        status: event.status,
        category: event.category,
      );
      yield ComplaintListUpdated(complaints);
    } else if (event is DeleteComplaint) {
      complaints.removeAt(event.index);
      yield ComplaintListUpdated(complaints);
    }
  }
}
