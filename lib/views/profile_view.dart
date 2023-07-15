import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubits/users_data_cubit/users_data_cubit.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/utils/app_routes.dart';
import 'package:todo_app/views/widgets/user_info_card.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserModel? currentUser;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
        ),
        body: BlocConsumer<UsersDataCubit, UsersDataState>(
          listener: (context, state) {
            if (state is GetCurrentUserSuccess) {
              currentUser =
                  BlocProvider.of<UsersDataCubit>(context).currentUser;
            }
          },
          builder: (context, state) {
            return state is GetCurrentUserLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      UserInfoCard(
                        info: 'First Name',
                        infoValue: currentUser!.firstName,
                        onEditPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.kEditUserInfoView, arguments: {
                            'field': 'firstName',
                            'value': currentUser!.firstName
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      UserInfoCard(
                        info: 'Username',
                        infoValue: currentUser!.username,
                        onEditPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.kEditUserInfoView, arguments: {
                            'field': 'username',
                            'value': currentUser!.username
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      UserInfoCard(
                        info: 'Password',
                        infoValue: '',
                        onEditPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.kEditUserInfoView,
                              arguments: {'field': 'password', 'value': ''});
                        },
                      ),
                    ],
                  );
          },
        ),
      );
    });
  }
}
