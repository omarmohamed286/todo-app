import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';
import '../../services/api_service.dart';

part 'users_data_state.dart';

class UsersDataCubit extends Cubit<UsersDataState> {
  UsersDataCubit(this.apiService) : super(UsersDataInitial());

  final ApiService apiService;

  UserModel? currentUser;

  Future<void> getCurrentUser({required String token}) async {
    emit(GetCurrentUserLoading());
    try {
      currentUser = await apiService.getUser(token: token);
      emit(GetCurrentUserSuccess());
    } catch (e) {
      emit(GetCurrentUserFailure(e.toString()));
    }
  }

  Future<void> updateUser(
      {required String token,
      required String field,
      required String newValue}) async {
    emit(UpdateUserLoading());
    try {
      await apiService.updateUser(
          token: token, field: field, newValue: newValue);
      emit(UpdateUserSuccess());
    } catch (e) {
      emit(UpdateUserFailure(e.toString()));
    }
  }
}
