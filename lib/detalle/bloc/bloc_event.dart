part of 'bloc_bloc.dart';

@immutable
abstract class BlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetProduct extends BlocEvent {
  final int id;
  GetProduct(this.id);
  @override
  List<Object> get props => [];
}
