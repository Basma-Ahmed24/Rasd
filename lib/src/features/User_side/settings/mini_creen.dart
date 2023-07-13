import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/language_localization.dart';
import '../../../core/network/shared_preferences.dart';
import '../../../core/utils/constants.dart';
import '../profile/cubit.dart';
import '../profile/state.dart';

Widget mini(
    BuildContext context,
    UserCubit? cubit, {
      bool? isEmail = false,
      bool? IsPhone = false,
    }) {
  String? newemail, newphone;
  return BlocListener<UserCubit, UserState>(
    bloc: cubit,
    listener: (context, state) {
      if (state is UserLoaded) {
        cubit!.getUserData(CacheHelper.getData(key: "apiToken"));
      }
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Change Info',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black54,
          ),
        ),
        TextField(
          autofocus: true,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, color: Color.fromRGBO(67, 37, 95, 1)),
          onChanged: (newText) {
            if (isEmail!) {
              newemail = newText;
            }
            if (IsPhone!) {
              newphone = newText;
            }
          },
          onSubmitted: (value) {
            if (isEmail!) {
              newemail = value;
            }
            if (IsPhone!) {
              newphone = value;
            }
          },
        ),
        ElevatedButton(
          onPressed: () async {
            if (isEmail!) {
              await cubit!.updateUserGmail(
                  CacheHelper.getData(key: "apiToken"), newemail!);
            }
            if (IsPhone!) {
              await cubit!.updateUserphone(
                  CacheHelper.getData(key: "apiToken"), newphone!);
            }
            Navigator.pop(context);
          },
          style: ButtonStyle(

              backgroundColor: MaterialStateProperty.all(green)),
          child:  Text(
            '${AppLocalizations.of(context)?.translate("change")}',
            style: TextStyle(color: Colors.white, fontSize:18 ),
          ),
        ),
      ],
    ),
  );
}