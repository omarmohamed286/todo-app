import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'change_password_icon_state.dart';

class ChangePasswordIconCubit extends Cubit<ChangePasswordIconState> {
  ChangePasswordIconCubit() : super(ChangePasswordIconInitial());

  bool obscureText = true;
  IconData hiddenPasswordIcon = Icons.visibility_off;
  IconData shownPasswordIcon = Icons.visibility;
  bool iconPressed = false;

  void changePasswordIcon() {
    obscureText = !obscureText;
    iconPressed = !iconPressed;
    emit(ChangePasswordIconInitial());
  }

  IconData getIcon() {
    if (iconPressed) {
      return hiddenPasswordIcon;
    } else {
      return shownPasswordIcon;
    }
  }
}