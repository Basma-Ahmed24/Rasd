import 'Profile_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {

}

class UserError extends UserState {
  final String errorMessage;

  UserError(this.errorMessage);
}
