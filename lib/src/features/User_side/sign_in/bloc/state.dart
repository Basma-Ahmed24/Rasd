

import 'User.dart';

abstract class LoginStates {
}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSucessState extends LoginStates{
  final User ?model;
  LoginSucessState(this.model);
}
class LoginErorrState extends LoginStates{
  final String erorr;
  LoginErorrState(this.erorr);
}
