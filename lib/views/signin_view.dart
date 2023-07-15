import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:todo_app/cubits/change_password_icon_cubit/change_password_icon_cubit.dart';
import 'package:todo_app/utils/app_styles.dart';
import 'package:todo_app/views/widgets/custom_text_field.dart';

import '../services/api_service.dart';
import '../services/dep_inj_service.dart';
import '../utils/app_routes.dart';
import 'widgets/custom_button.dart';
import 'widgets/custom_password_text_field.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  String? username, password;
  final formsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordIconCubit(),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: formsKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sign In',
                    style: AppStyles.textStyle32,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    labelText: 'Username',
                    onSaved: (value) {
                      username = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomPasswordTextFormField(
                    labelText: 'Password',
                    onSaved: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Don't have an account yet?",
                        style: AppStyles.textStyle18,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign Up',
                            style: AppStyles.textStyle24,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is SigninSuccessState) {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.kHomeView);
                        }
                      },
                      builder: (context, state) {
                        return state is SigninLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                text: 'Sign In',
                                onPressed: () {
                                  if (formsKey.currentState!.validate()) {
                                    formsKey.currentState!.save();
                                    BlocProvider.of<AuthCubit>(context).signin(
                                        username: username!,
                                        password: password!);
                                  }
                                },
                              );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
