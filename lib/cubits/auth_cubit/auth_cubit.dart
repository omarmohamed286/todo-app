import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/services/api_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.apiService) : super(AuthInitial());

  final ApiService apiService;

  Future<void> signup(
      {required String firstName,
      required String username,
      required String password}) async {
    emit(SignupLoadingState());
    try {
      await apiService.signup(
          firstName: firstName, username: username, password: password);
      emit(SignupSuccessState());
    } catch (e) {
      emit(SignupFailureState(e.toString()));
    }
  }

  Future<void> signin(
      {required String username, required String password}) async {
    emit(SigninLoadingState());
    try {
      await apiService.signin(username: username, password: password);
      emit(SigninSuccessState());
    } catch (e) {
      emit(SigninFailureState(e.toString()));
    }
  }
}
