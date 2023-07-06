

abstract class ProjNewsState {}

class projnewsInitial extends ProjNewsState {}

class projnewsLoading extends ProjNewsState {}

class projnewsLoaded extends ProjNewsState {

}

class projnewsError extends ProjNewsState {
  final String errorMessage;

  projnewsError(this.errorMessage);
}
