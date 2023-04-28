part of 'bloc_bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginPost extends BlocEvent {
  final Login login;
  LoginPost(this.login);
  @override
  List<Object> get props => [];
}
