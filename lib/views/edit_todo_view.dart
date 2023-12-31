import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/todos_cubit/todos_cubit.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/views/widgets/custom_button.dart';
import 'package:todo_app/views/widgets/custom_text_field.dart';

class EditTodoView extends StatefulWidget {
  const EditTodoView({super.key});

  @override
  State<EditTodoView> createState() => _EditTodoViewState();
}

class _EditTodoViewState extends State<EditTodoView> {
  String? newTitle;

  @override
  Widget build(BuildContext context) {
    TodoModel todo =
        ModalRoute.of(context)!.settings.arguments as TodoModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              labelText: 'Edit',
              textInputAction: TextInputAction.done,
              initialValue: todo.title,
              onChanged: (value) {
                newTitle = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            BlocConsumer<TodosCubit, TodosState>(
              listener: (context, state) {
                if (state is EditTodoSuccess) {
                  BlocProvider.of<TodosCubit>(context)
                      .getTodos(token: token!);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return state is EditTodoLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: 'Confirm',
                        onPressed: () {
                          if (newTitle != null) {
                            BlocProvider.of<TodosCubit>(context).editTodo(
                                token: token!,
                                todoId: todo.id,
                                newTitle: newTitle!);
                          }
                        },
                      );
              },
            )
          ],
        ),
      )),
    );
  }
}
