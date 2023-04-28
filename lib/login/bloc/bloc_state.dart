part of 'bloc_bloc.dart';

@immutable
abstract class BlocState extends Equatable {
  final Model model;
  const BlocState(this.model);

  @override
  List<Object> get props => [model];
}

class BlocInitial extends BlocState {
  const BlocInitial(Model model) : super(model);
}

class LoginState extends BlocState {
  const LoginState(Model model) : super(model);
}

class NextState extends BlocState {
  const NextState(Model model) : super(model);
}

class ErrorState extends BlocState {
  const ErrorState(Model model) : super(model);
}

class ErrorCredencialState extends BlocState {
  const ErrorCredencialState(Model model) : super(model);
}

class Model extends Equatable {
  final Usuario? usuario;
  const Model({this.usuario});

  Model copyWith({Usuario? usuario}) => Model(usuario: usuario ?? this.usuario);

  @override
  List<Object> get props => [];
}
