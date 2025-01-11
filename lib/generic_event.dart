import 'package:equatable/equatable.dart';

abstract class GenericEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Generic event for submitting data
class SubmitData extends GenericEvent {
  final Map<String, dynamic> data;

  SubmitData({required this.data});

  @override
  List<Object?> get props => [data];
}

/// Event for fetching data (general-purpose)
class FetchData extends GenericEvent {}

/// Event for submitting a leave request
class SubmitLeaveRequest extends GenericEvent {
  final Map<String, dynamic> data;

  SubmitLeaveRequest({required this.data});

  @override
  List<Object?> get props => [data];
}

/// Event for submitting a vacation request
class SubmitVacationRequest extends GenericEvent {
  final Map<String, dynamic> data;

  SubmitVacationRequest({required this.data});

  @override
  List<Object?> get props => [data];
}

/// Event for fetching vacation history with optional filters
class FetchVacationHistory extends GenericEvent {
  final DateTime? fromDate;
  final DateTime? toDate;

  FetchVacationHistory({this.fromDate, this.toDate});

  @override
  List<Object?> get props => [fromDate, toDate];
}
