import 'package:dio/dio.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/cache_service.dart';
import 'package:todo_app/services/dep_inj_service.dart';

class ApiService {
  Dio dio = Dio(BaseOptions(
    headers: {},
    validateStatus: (statusCode) {
      if (statusCode == null) {
        return false;
      }
      if (statusCode == 422) {
        return true;
      } else {
        return statusCode >= 200 && statusCode < 300;
      }
    },
  ));

  String baseUrl = 'https://todo-app-api-vqgq.onrender.com';

  Future<void> signup(
      {required String firstName,
      required String username,
      required String password}) async {
    final response = await dio.post('$baseUrl/users/register', data: {
      'firstName': firstName,
      'username': username,
      'password': password
    });
    print('The api response is $response');
    await signin(username: username, password: password);
  }

  Future<void> signin(
      {required String username, required String password}) async {
    final response = await dio.post('$baseUrl/users/login',
        data: {'username': username, 'password': password});
    print('The api response is $response');
    await getIt<CacheService>()
        .saveData(key: 'token', value: response.data['token']);
  }

  Future<void> addTodo({required String token, required String title}) async {
    final response = await dio.post(
      '$baseUrl/todos',
      data: {'title': title},
      options: Options(
        headers: {
          "Authorization": token,
        },
      ),
    );
    print('The api response is $response');
  }

  Future<List<TodoModel>?> getTodos({required String token}) async {
    List<TodoModel> todos = [];
    final response = await dio.get(
      '$baseUrl/todos',
      options: Options(
        headers: {
          "Authorization": token,
        },
      ),
    );
    for (var todo in response.data) {
      todos.add(TodoModel.fromJson(todo));
    }
    return todos;
  }

  Future<void> deleteTodo(
      {required String token, required String todoId}) async {
    final response = await dio.delete(
      '$baseUrl/todos/$todoId',
      options: Options(
        headers: {
          "Authorization": token,
        },
      ),
    );
    print('The api response is $response');
  }

  Future<void> editTodo(
      {required String token,
      required String todoId,
      required String newTitle}) async {
    final response = await dio.patch(
      '$baseUrl/todos/$todoId',
      data: {'newTitle': newTitle},
      options: Options(
        headers: {
          "Authorization": token,
        },
      ),
    );
    print('The api response is $response');
  }
}
