import 'package:equatable/equatable.dart';

class User {
  User({
      required this.googleId,
      required this.passHash,});

  User.fromJson(dynamic json) {
    googleId = json['google_id'];
    passHash = json['pass_hash'];
  }
  String? googleId;
  String? passHash;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['google_id'] = googleId;
    map['pass_hash'] = passHash;
    return map;
  }}
  class SignInState extends Equatable {
  const SignInState({
  this.isLoading = false,
  this.isSuccess = false,
  this.errorMessage,
  this.signinModel,
  });

  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final User? signinModel;

  @override
  List<Object?> get props => [isLoading, isSuccess, errorMessage, signinModel];

  SignInState copyWith({
  bool? isLoading,
  bool? isSuccess,
  String? errorMessage,
    User? signinModel,
  }) {
  return SignInState(
  isLoading: isLoading ?? this.isLoading,
  isSuccess: isSuccess ?? this.isSuccess,
  errorMessage: errorMessage ?? this.errorMessage,
    signinModel: signinModel ?? this.signinModel,
  );
  }
  }


