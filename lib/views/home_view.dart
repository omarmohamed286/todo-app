import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/todos_cubit/todos_cubit.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/cache_service.dart';
import 'package:todo_app/services/dep_inj_service.dart';
import 'package:todo_app/utils/app_routes.dart';
import 'package:todo_app/views/widgets/bottom_sheet_body.dart';
import 'package:todo_app/views/widgets/custom_button.dart';
import 'package:todo_app/views/widgets/custom_text_field.dart';
import 'package:todo_app/views/widgets/todo_container.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<TodoModel>? todos = [];
  String? title;
  String? userToken;

  @override
  void initState() {
    getTodos();
    super.initState();
  }

  Future<void> getTodos() async {
    userToken = await getIt<CacheService>().getData(key: 'token');
    if (context.mounted) {
      BlocProvider.of<TodosCubit>(context).getTodos(token: userToken!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodosCubit, TodosState>(
      listener: (context, state) {
        if (state is GetTodosSuccess) {
          todos = BlocProvider.of<TodosCubit>(context).todos;
        } else if (state is AddTodoSuccess) {
          BlocProvider.of<TodosCubit>(context).getTodos(token: userToken!);
          Navigator.pop(context);
        } else if (state is DeleteTodoSuccess) {
          BlocProvider.of<TodosCubit>(context).getTodos(token: userToken!);
        }
      },
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (bottomSheetContext) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: BottomSheetBody(
                        onChanged: (value) {
                          title = value;
                        },
                        onPressed: () {
                          if (title != null) {
                            BlocProvider.of<TodosCubit>(context)
                                .addTodo(token: userToken!, title: title!);
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
            appBar: AppBar(
              title: const Text('Todos'),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: state is GetTodosLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: todos!.length,
                    itemBuilder: (context, index) {
                      return TodoContainer(
                        toDoTitle: todos![index].title,
                        onRemoveIconPressed: () {
                          BlocProvider.of<TodosCubit>(context).deleteTodo(
                              token: userToken!, todoId: todos![index].id);
                        },
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.kEditTodoView,
                              arguments: {
                                'todo': todos![index],
                                'userToken': userToken!
                              });
                        },
                      );
                    },
                  ));
      },
    );
  }
}