import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/change_password_icon_cubit/change_password_icon_cubit.dart';
import 'package:todo_app/cubits/users_data_cubit/users_data_cubit.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/views/widgets/custom_button.dart';
import 'package:todo_app/views/widgets/custom_password_text_field.dart';
import 'package:todo_app/views/widgets/custom_text_field.dart';


class EditUserInfoView extends StatefulWidget {
  const EditUserInfoView({super.key});

  @override
  State<EditUserInfoView> createState() => _EditUserInfoViewState();
}

class _EditUserInfoViewState extends State<EditUserInfoView> {
  String? newValue;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return BlocProvider(
      create: (context) => ChangePasswordIconCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Info'),
          centerTitle: true,
        ),
        body: BlocConsumer<UsersDataCubit, UsersDataState>(
          listener: (context, state) {
            if (state is UpdateUserSuccess) {
              BlocProvider.of<UsersDataCubit>(context)
                  .getCurrentUser(token: token!);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  arguments['field'] == 'password'
                      ? CustomPasswordTextFormField(
                          labelText: 'password',
                          onChanged: (value) {
                            newValue = value;
                          },
                        )
                      : CustomTextField(
                          labelText: getLabelText(field: arguments['field']),
                          initialValue: arguments['value'],
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            newValue = value;
                          },
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  state is UpdateUserLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: 'Confirm',
                          onPressed: () {
                            if (newValue != null) {
                              BlocProvider.of<UsersDataCubit>(context)
                                  .updateUser(
                                      token: token!,
                                      field: arguments['field'],
                                      newValue: newValue!);
                            }
                          },
                        )
                ],
              ),
            ));
          },
        ),
      ),
    );
  }

  String getLabelText({required String field}) {
    if (field == 'firstName') {
      return 'First Name';
    } else if (field == 'username') {
      return 'Username';
    }
    return 'Password';
  }
}
