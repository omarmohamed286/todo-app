import 'package:flutter/material.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard(
      {super.key,
      required this.info,
      required this.infoValue,
      this.onEditPressed});

  final String info;
  final String infoValue;
  final void Function()? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        info,
      ),
      subtitle: Text(
        infoValue,
      ),
      trailing: onEditPressed == null
          ? null
          : TextButton(
              onPressed: onEditPressed,
              child: const Text(
                'Edit',
              )),
    );
  }
}
