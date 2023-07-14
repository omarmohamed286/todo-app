import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/todos_cubit/todos_cubit.dart';
import 'package:todo_app/services/cache_service.dart';
import 'package:todo_app/utils/app_routes.dart';

import 'services/api_service.dart';
import 'services/dep_inj_service.dart';

String? token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  token = await getIt<CacheService>().getData(key: 'token');
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosCubit(getIt<ApiService>()),
      child: MaterialApp(
        initialRoute: token?.isEmpty ?? true
            ? AppRoutes.kSignupView
            : AppRoutes.kHomeView,
        routes: AppRoutes.routes,
      ),
    );
  }
}
