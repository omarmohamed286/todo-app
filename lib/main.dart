import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/todos_cubit/todos_cubit.dart';
import 'package:todo_app/cubits/users_data_cubit/users_data_cubit.dart';
import 'package:todo_app/services/cache_service.dart';
import 'package:todo_app/utils/app_routes.dart';

import 'services/api_service.dart';
import 'services/dep_inj_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  getUserToken();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosCubit(getIt<ApiService>()),
        ),
        BlocProvider(
          create: (context) => UsersDataCubit(getIt<ApiService>())
            ..getCurrentUser(token: token!),
        ),
      ],
      child: MaterialApp(
        initialRoute: token?.isEmpty ?? true
            ? AppRoutes.kSignupView
            : AppRoutes.kHomeView,
        routes: AppRoutes.routes,
      ),
    );
  }
}

String? token;
Future<void> getUserToken() async {
  token = await getIt<CacheService>().getData(key: 'token');
}
