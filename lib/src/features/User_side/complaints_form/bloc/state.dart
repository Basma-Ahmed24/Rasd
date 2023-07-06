import 'package:equatable/equatable.dart';

import 'ComplaintModel.dart';

class ComplaintState extends Equatable {
  const ComplaintState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.complaintModel,
  });

  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final ComplaintModel? complaintModel;

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage, complaintModel];

  ComplaintState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    ComplaintModel? signUpModel,
  }) {
    return ComplaintState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      complaintModel: signUpModel ?? this.complaintModel,

    );
  }

}