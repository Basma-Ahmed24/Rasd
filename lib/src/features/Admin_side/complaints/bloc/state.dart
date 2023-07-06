

abstract class ComplaintsState {}

class ComplaintInitial extends ComplaintsState {}

class ComplaintLoading extends ComplaintsState {}

class ComplaintLoaded extends ComplaintsState {

}

class ComplaintsError extends ComplaintsState {
  final String errorMessage;

  ComplaintsError(this.errorMessage);
}
