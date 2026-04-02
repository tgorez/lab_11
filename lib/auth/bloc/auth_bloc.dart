import 'package:flutter_application_7/auth/bloc/auth_event.dart';
import 'package:flutter_application_7/auth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());

      await Future.delayed(const Duration(seconds: 1));

      emit(AuthSuccess(
        name: event.name,
        email: event.email,
        phone: event.phone,
      ));
    });
  }
}