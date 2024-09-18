import 'package:alumni_connect/core/raw_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 1)); // Simulate loading

      try {
        // Search for user in the list
        final user = users.firstWhere(
          (user) =>
              user['email'] == event.email &&
              user['password'] == event.password,
          orElse: () => {},
        );

        if (user.isNotEmpty) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure('Invalid email or password'));
        }
      } catch (error) {
        emit(LoginFailure(error.toString()));
      }
    });
  }
}
