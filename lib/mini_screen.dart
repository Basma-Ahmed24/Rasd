// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rasd/controller/user_bloc/user_cubit.dart';
import 'package:rasd/models/auth_models.dart';

Widget mini(
  BuildContext context,
  UserCubit? cubit, {
  bool? isName = false,
  bool? isPass = false,
}) {
  String? newname, newpass;
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Change Info',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      TextField(
        autofocus: true,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Color.fromRGBO(67, 37, 95, 1)),
        onChanged: (newText) {
          if (isName!) {
            newname = newText;
          }
          if (isPass!) {
            newpass = newText;
          }
        },
        onSubmitted: (value) {
          if (isName!) {
            newname = value;
          }
          if (isPass!) {
            newpass = value;
          }
        },
      ),
      ElevatedButton(
        onPressed: () async {
          if (isName!) {
            await cubit!.addUserInfo(
              context,
              AuthModels(name: newname),
              isUpdateName: true,
            );
          }
          if (isPass!) {
            await cubit!.addUserInfo(
              context,
              AuthModels(),
              isUpdatePassword: true,
              newPassword: newpass,
            );
          }
        },
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
                EdgeInsets.fromLTRB(100, 15, 100, 15)),
            backgroundColor: MaterialStateProperty.all(Colors.orange)),
        child: const Text(
          'change',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    ],
  );
}
