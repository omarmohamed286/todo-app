import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/services/api_service.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit(this.apiService) : super(TodosInitial());

  final ApiService apiService;

  List<TodoModel>? todos = [];

  Future<void> addTodo({required String token, required String title}) async {
    emit(AddTodoLoading());
    try {
      await apiService.addTodo(token: token, title: title);
      emit(AddTodoSuccess());
    } catch (e) {
      print(e.toString());
      emit(AddTodoFailure(e.toString()));
    }
  }

  Future<void> getTodos({required String token}) async {
    emit(GetTodosLoading());
    try {
      todos = await apiService.getTodos(token: token);
      emit(GetTodosSuccess());
    } catch (e) {
      print(e.toString());
      emit(GetTodosFailure(e.toString()));
    }
  }

  Future<void> deleteTodo(
      {required String token, required String todoId}) async {
    try {
      await apiService.deleteTodo(token: token, todoId: todoId);
      emit(DeleteTodoSuccess());
    } catch (e) {
      print(e.toString());
      emit(DeleteTodoFailure(e.toString()));
    }
  }

  Future<void> editTodo(
      {required String token,
      required String todoId,
      required String newTitle}) async {
    emit(EditTodoLoading());
    try {
      await apiService.editTodo(
          token: token, todoId: todoId, newTitle: newTitle);
      emit(EditTodoSuccess());
    } catch (e) {
      print(e.toString());
      emit(EditTodoFailure(e.toString()));
    }
  }
}
