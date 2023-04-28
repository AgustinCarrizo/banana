import 'package:banana/detalle/repository.dart';
import 'package:banana/model/producto.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';
part 'bloc_event.dart';
part 'bloc_state.dart';

class BlocBloc extends Bloc<BlocEvent, BlocState> {
  final Repository repository;
  BlocBloc([Repository? repository])
      : repository = repository ?? Repository(),
        super(const BlocInitial(Model())) {
    on<GetProduct>((event, emit) => metodoGetProduct(event, emit));
  }

  Future<void> metodoGetProduct(GetProduct event, Emitter<BlocState> emit) async {
    emit(
      LoginState(
        state.model,
      ),
    );
    late Producto producto;

    try {
      producto = await repository.getProductoDetlle(event.id);
    } catch (e) {
      if (e == DioErrorType.connectionError) return;
    }
    emit(
      CompleteState(
        state.model.copyWith(producto: producto),
      ),
    );
  }
}
