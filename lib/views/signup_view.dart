import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:todo_app/cubits/change_password_icon_cubit/change_password_icon_cubit.dart';
import 'package:todo_app/services/api_service.dart';
import 'package:todo_app/services/dep_inj_service.dart';
import 'package:todo_app/utils/app_routes.dart';
import 'package:todo_app/utils/app_styles.dart';
import 'package:todo_app/views/widgets/custom_text_field.dart';

import 'widgets/custom_button.dart';
import 'widgets/custom_password_text_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  String? firstName, username, password;

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
                    'Sign Up',
                    style: AppStyles.textStyle32,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                    labelText: 'First Name',
                    onSaved: (value) {
                      firstName = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
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
                        'Have an account already?',
                        style: AppStyles.textStyle18,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.kSigninView);
                          },
                          child: const Text(
                            'Sign In',
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
                        if (state is SignupSuccessState) {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.kHomeView);
                        } else if (state is SignupFailureState) {
                          print('Error from signup: ${state.errMessage}');
                        }
                      },
                      builder: (context, state) {
                        return state is SignupLoadingState
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                text: 'Sign Up',
                                onPressed: () {
                                  if (formsKey.currentState!.validate()) {
                                    formsKey.currentState!.save();
                                    BlocProvider.of<AuthCubit>(context).signup(
                                        firstName: firstName!,
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
