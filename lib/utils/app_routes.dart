import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:todo_app/services/api_service.dart';
import 'package:todo_app/services/dep_inj_service.dart';
import 'package:todo_app/views/edit_todo_view.dart';
import 'package:todo_app/views/edit_user_info_view.dart';
import 'package:todo_app/views/home_view.dart';
import 'package:todo_app/views/profile_view.dart';
import 'package:todo_app/views/signin_view.dart';
import 'package:todo_app/views/signup_view.dart';


class AppRoutes {
  static const kSigninView = 'signinView';
  static const kSignupView = 'signupView';
  static const kHomeView = 'homeView';
  static const kEditTodoView = 'editTodoView';
  static const kProfileView = 'profileView';
  static const kEditUserInfoView = 'editUserInfoView';

  static Map<String, Widget Function(BuildContext)> routes = {
    kSigninView: (context) => BlocProvider(
          create: (context) => AuthCubit(getIt<ApiService>()),
          child: const SigninView(),
        ),
    kSignupView: (context) => BlocProvider(
          create: (context) => AuthCubit(getIt<ApiService>()),
          child: const SignupView(),
        ),
    kHomeView: (context) => const HomeView(),
    kEditTodoView: (context) => const EditTodoView(),
    kProfileView: (context) => const ProfileView(),
    kEditUserInfoView: (context) => const EditUserInfoView()
  };
}
