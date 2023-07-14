part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignupLoadingState extends AuthState {}

class SignupSuccessState extends AuthState {}

class SignupFailureState extends AuthState {
  final String errMessage;

  SignupFailureState(this.errMessage);
}

class SigninLoadingState extends AuthState {}

class SigninSuccessState extends AuthState {}

class SigninFailureState extends AuthState {
  final String errMessage;

  SigninFailureState(this.errMessage);
}
