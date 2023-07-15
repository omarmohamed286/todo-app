part of 'users_data_cubit.dart';

@immutable
abstract class UsersDataState {}

class UsersDataInitial extends UsersDataState {}

class GetCurrentUserLoading extends UsersDataState {}

class GetCurrentUserSuccess extends UsersDataState {}

class GetCurrentUserFailure extends UsersDataState {
  final String errMessage;

  GetCurrentUserFailure(this.errMessage);
}

class UpdateUserLoading extends UsersDataState {}

class UpdateUserSuccess extends UsersDataState {}

class UpdateUserFailure extends UsersDataState {
  final String errMessage;

  UpdateUserFailure(this.errMessage);
}

