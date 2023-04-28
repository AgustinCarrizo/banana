import 'package:banana/home/repository.dart';
import 'package:banana/model/producto.dart';
import 'package:banana/model/productos.dart';
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
    on<GetProducto>((event, emit) => metodoLoginPost(event, emit));
    on<Filter>((event, emit) => metodoFilter(event, emit));
  }

  Future<void> metodoLoginPost(
      GetProducto event, Emitter<BlocState> emit) async {
    emit(
      LoginState(
        state.model,
      ),
    );
    late Productos producto;

    try {
      producto = await repository.getProductos();
    } catch (e) {
      
      if (e == DioErrorType.connectionError) return;
    }
    emit(
      ProuctoState(
        state.model.copyWith(producto: producto.products),
      ),
    );
  }
  Future<void> metodoFilter(
      Filter event, Emitter<BlocState> emit) async {
    emit(
      LoginState(
        state.model,
      ),
    );
    late Productos producto;

    try {
      producto = await repository.getFilter(event.filter);
    } catch (e) {
      if (e == DioErrorType.connectionError) return;
    }
    emit(
      ProuctoState(
        state.model.copyWith(producto: producto.products),
      ),
    );
  }
}
