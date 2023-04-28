part of 'bloc_bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProducto extends BlocEvent {
  @override
  List<Object> get props => [];
}

class Filter extends BlocEvent {
  final String filter;
  Filter(this.filter);
  @override
  List<Object> get props => [];
}
