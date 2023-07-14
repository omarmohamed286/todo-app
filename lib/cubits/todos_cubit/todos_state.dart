part of 'todos_cubit.dart';

@immutable
abstract class TodosState {}

class TodosInitial extends TodosState {}

class AddTodoLoading extends TodosState {}

class AddTodoSuccess extends TodosState {}

class AddTodoFailure extends TodosState {
  final String errMessage;

  AddTodoFailure(this.errMessage);
}

class GetTodosLoading extends TodosState {}

class GetTodosSuccess extends TodosState {}

class GetTodosFailure extends TodosState {
  final String errMessage;

  GetTodosFailure(this.errMessage);
}

class DeleteTodoSuccess extends TodosState {}

class DeleteTodoFailure extends TodosState {
  final String errMessage;

  DeleteTodoFailure(this.errMessage);
}

class EditTodoLoading extends TodosState {}

class EditTodoSuccess extends TodosState {}

class EditTodoFailure extends TodosState {
  final String errMessage;

  EditTodoFailure(this.errMessage);
}
