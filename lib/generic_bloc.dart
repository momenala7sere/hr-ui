import 'package:flutter_bloc/flutter_bloc.dart';
import 'generic_event.dart';
import 'generic_state.dart';

class GenericBloc extends Bloc<GenericEvent, GenericState> {
  final Future<dynamic> Function(Map<String, dynamic> data)? submitDataCallback;
  final Future<dynamic> Function()? fetchDataCallback;

  GenericBloc({this.submitDataCallback, this.fetchDataCallback}) : super(GenericInitial()) {
    on<SubmitData>(_onSubmitData);
    on<FetchData>(_onFetchData);
    on<SubmitLeaveRequest>(_onSubmitLeaveRequest);
    on<SubmitVacationRequest>(_onSubmitVacationRequest);
    on<FetchVacationHistory>(_onFetchVacationHistory);
  }

  Future<void> _onSubmitData(SubmitData event, Emitter<GenericState> emit) async {
    emit(GenericLoading());
    try {
      if (submitDataCallback == null) {
        throw Exception("SubmitData callback is not implemented.");
      }
      final result = await submitDataCallback!(event.data);
      emit(GenericLoaded(result));
    } catch (e) {
      emit(GenericError(e.toString()));
    }
  }

  Future<void> _onFetchData(FetchData event, Emitter<GenericState> emit) async {
    emit(GenericLoading());
    try {
      if (fetchDataCallback == null) {
        throw Exception("FetchData callback is not implemented.");
      }
      final result = await fetchDataCallback!();
      emit(GenericLoaded(result));
    } catch (e) {
      emit(GenericError(e.toString()));
    }
  }

  Future<void> _onSubmitLeaveRequest(SubmitLeaveRequest event, Emitter<GenericState> emit) async {
    emit(GenericLoading());
    try {
      final result = {
        'success': true,
        'message': 'Leave request submitted successfully!',
        'data': event.data,
      };
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      emit(GenericLoaded(result));
    } catch (e) {
      emit(GenericError('Failed to submit leave request: $e'));
    }
  }

  Future<void> _onSubmitVacationRequest(SubmitVacationRequest event, Emitter<GenericState> emit) async {
    emit(GenericLoading());
    try {
      final result = {
        'success': true,
        'message': 'Vacation request submitted successfully!',
        'data': event.data,
      };
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      emit(GenericLoaded(result));
    } catch (e) {
      emit(GenericError('Failed to submit vacation request: $e'));
    }
  }

  Future<void> _onFetchVacationHistory(FetchVacationHistory event, Emitter<GenericState> emit) async {
    emit(GenericLoading());
    try {
      // Example vacation history data
      final List<Map<String, dynamic>> vacationHistory = [
        {
          'id': '2520',
          'employee': 'Mohammed',
          'requestDate': '01/06/2023 11:02:21',
          'requestType': 'Quota',
          'from': DateTime(2023, 6, 1),
          'to': DateTime(2023, 6, 10),
          'status': 'Requested',
        },
        {
          'id': '2521',
          'employee': 'Ali',
          'requestDate': '05/07/2023 09:15:30',
          'requestType': 'Sick',
          'from': DateTime(2023, 7, 5),
          'to': DateTime(2023, 7, 8),
          'status': 'Approved',
        },
      ];

      final fromDate = event.fromDate ?? DateTime(2000);
      final toDate = event.toDate ?? DateTime(2101);

      final filteredHistory = vacationHistory.where((record) {
        final recordFrom = record['from'] as DateTime;
        final recordTo = record['to'] as DateTime;
        return recordFrom.isAfter(fromDate.subtract(const Duration(days: 1))) &&
            recordTo.isBefore(toDate.add(const Duration(days: 1)));
      }).toList();

      emit(GenericLoaded(filteredHistory));
    } catch (e) {
      emit(GenericError('Failed to fetch vacation history: $e'));
    }
  }
}
