import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/services/cache_service.dart';
import 'package:todo_app/services/dep_inj_service.dart';
import 'package:todo_app/utils/app_routes.dart';
import 'package:todo_app/views/widgets/drawer_card.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DrawerCard(
              title: 'Profile',
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.kProfileView);
              },
              icon: Icons.person),
          DrawerCard(
              title: 'Sign Out',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Are you sure you want to sign out?'),
                      actions: [
                        TextButton(
                          child: const Text(
                            'No',
                            style: TextStyle(color: Colors.green),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: const Text(
                            'Yes',
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () async {
                            await getIt<CacheService>()
                                .deleteData(key: 'token');
                            token = null;
                            if (context.mounted) {
                              Navigator.pushNamed(
                                  context, AppRoutes.kSignupView);
                            }
                          },
                        )
                      ],
                    );
                  },
                );
              },
              icon: Icons.exit_to_app)
        ],
      ),
    );
  }
}
