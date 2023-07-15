import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/todos_cubit/todos_cubit.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/utils/app_routes.dart';
import 'package:todo_app/views/widgets/bottom_sheet_body.dart';
import 'package:todo_app/views/widgets/todo_container.dart';

import 'widgets/custom_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<TodoModel>? todos = [];
  String? title;

  @override
  void initState() {
    getUserToken().then((value) {
      BlocProvider.of<TodosCubit>(context).getTodos(token: token!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodosCubit, TodosState>(
      listener: (context, state) {
        if (state is GetTodosSuccess) {
          todos = BlocProvider.of<TodosCubit>(context).todos;
        } else if (state is AddTodoSuccess) {
          BlocProvider.of<TodosCubit>(context).getTodos(token: token!);
          Navigator.pop(context);
        } else if (state is DeleteTodoSuccess) {
          BlocProvider.of<TodosCubit>(context).getTodos(token: token!);
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
                                .addTodo(token: token!, title: title!);
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
            ),
            drawer: const CustomDrawer(),
            body: state is GetTodosLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: todos!.length,
                    itemBuilder: (context, index) {
                      return TodoContainer(
                        toDoTitle: todos![index].title,
                        onRemoveIconPressed: () {
                          BlocProvider.of<TodosCubit>(context).deleteTodo(
                              token: token!, todoId: todos![index].id);
                        },
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.kEditTodoView,
                              arguments: todos![index]);
                        },
                      );
                    },
                  ));
      },
    );
  }
}
