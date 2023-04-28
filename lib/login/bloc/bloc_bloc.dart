
import 'package:banana/login/repository.dart';
import 'package:banana/model/login.dart';
import 'package:banana/model/usuario.dart';
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
    on<LoginPost>((event, emit) => metodoLoginPost(event, emit));
  }

  Future<void> metodoLoginPost(LoginPost event, Emitter<BlocState> emit) async {
    emit(
      LoginState(
        state.model,
      ),
    );
    late Usuario usuario;

    try {
      usuario = await repository.postLogin(event.login);
    } catch (e) {
      if (e == DioErrorType.connectionError) return;
      var error = e as DioError;
      if (error.response?.statusCode == 400) {
        emit(
          ErrorCredencialState(
            state.model,
          ),
        );
        return;
      }
    }
    emit(
      NextState(
        state.model.copyWith(usuario: usuario),
      ),
    );
  }
}
